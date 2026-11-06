#!/usr/bin/env python3
"""
build.py - Script de automação e compilação dos templates LaTeX da AX Academy / IFAM.
Gerencia compilação via LuaLaTeX, verificação de dependências, fontes compartilhadas
e organização das saídas em diretório centralizado (dist/).
"""

from __future__ import annotations

import json
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path
from typing import Any, Dict, List, Optional

import click
from rich.console import Console
from rich.panel import Panel
from rich.table import Table

console = Console()

ROOT_DIR = Path(__file__).resolve().parent
CONFIG_PATH = ROOT_DIR / "templates.config.json"

DEFAULT_CONFIG: Dict[str, Any] = {
    "output_dir": "dist",
    "fonts_dir": "fonts",
    "clean_aux_after_build": True,
    "compiler_path": None,
    "templates": {
        "apostila": {
            "name": "Apostila",
            "directory": "Apostila",
            "entrypoint": "guia-rapido.tex",
            "output_name": "guia-rapido.pdf",
            "passes": 2,
            "description": "Guia Rápido de Uso multi-página (classe book, sumário, capítulos em caps/)",
        },
        "flyer": {
            "name": "Flyer",
            "directory": "Flyer",
            "entrypoint": "guia-flyer.tex",
            "output_name": "guia-flyer.pdf",
            "passes": 1,
            "description": "Guia Rápido em folha única A3 paisagem (grade de 4x2 cartões com capturas)",
        },
        "onepage": {
            "name": "OnePage",
            "directory": "One-page",
            "entrypoint": "onepage-lg.tex",
            "output_name": "onepage-lg.pdf",
            "passes": 2,
            "description": "OnePage corporativo LGE (layout 33.87 x 19.05 cm, Antes / Depois / Resultado)",
        },
    },
}

AUX_EXTENSIONS = [
    ".aux",
    ".log",
    ".out",
    ".toc",
    ".ptc",
    ".fls",
    ".fdb_latexmk",
    ".synctex.gz",
    ".bbl",
    ".blg",
    ".nav",
    ".snm",
    ".vrb",
    ".lot",
    ".lof",
    ".idx",
    ".ilg",
    ".ind",
    ".loa",
]

EXPECTED_FONTS = [
    "LGEIHeadlineTTF-Bold.ttf",
    "LGEIHeadlineTTF-Light.ttf",
    "LGEIHeadlineTTF-Regular.ttf",
    "LGEIHeadlineTTF-Semibold.ttf",
    "LGEIHeadlineTTF-Thin.ttf",
    "LGEIHeadlineVF.ttf",
    "LGEITextTTF-Bold.ttf",
    "LGEITextTTF-Light.ttf",
    "LGEITextTTF-Regular.ttf",
    "LGEITextTTF-SemiBold.ttf",
]


def load_config() -> Dict[str, Any]:
    if CONFIG_PATH.exists():
        try:
            with open(CONFIG_PATH, "r", encoding="utf-8") as f:
                return json.load(f)
        except Exception as e:
            console.print(f"[yellow]Aviso: Falha ao ler {CONFIG_PATH.name} ({e}). Usando padrão.[/yellow]")
    return DEFAULT_CONFIG


def get_lualatex_path(cfg: Optional[Dict[str, Any]] = None) -> Optional[str]:
    # 1. Caminho explícito configurado em templates.config.json
    if cfg and cfg.get("compiler_path"):
        custom = Path(cfg["compiler_path"])
        if custom.is_file():
            return str(custom)
        if (custom / "lualatex.exe").is_file():
            return str(custom / "lualatex.exe")

    # 2. Variável de ambiente (opção de override pelo usuário)
    env_custom = os.environ.get("LUALATEX_PATH") or os.environ.get("MIKTEX_BIN")
    if env_custom:
        p = Path(env_custom)
        if p.is_file():
            return str(p)
        if (p / "lualatex.exe").is_file():
            return str(p / "lualatex.exe")

    # 3. Procura no PATH do sistema operacional
    found = shutil.which("lualatex")
    if found:
        return found

    # 4. PADRÃO: Disco principal do sistema (C:\ ou %SystemDrive%)
    system_drive = os.environ.get("SystemDrive", "C:")
    primary_candidates = [
        rf"{system_drive}\Program Files\MiKTeX\miktex\bin\x64\lualatex.exe",
        rf"{system_drive}\Program Files\MiKTeX 2.9\miktex\bin\x64\lualatex.exe",
        os.path.expandvars(r"%LOCALAPPDATA%\Programs\MiKTeX\miktex\bin\x64\lualatex.exe"),
        rf"{system_drive}\texlive\2026\bin\windows\lualatex.exe",
        rf"{system_drive}\texlive\2025\bin\windows\lualatex.exe",
        rf"{system_drive}\texlive\2024\bin\windows\lualatex.exe",
    ]
    for c in primary_candidates:
        if os.path.isfile(c):
            return c

    # 5. OPCIONAL: Outros discos secundários (D:, E:, etc.)
    secondary_candidates = [
        r"D:\MiKTeX\miktex\bin\x64\lualatex.exe",
        r"D:\MiKTeX\bin\x64\lualatex.exe",
        r"D:\texlive\2026\bin\windows\lualatex.exe",
        r"D:\texlive\2025\bin\windows\lualatex.exe",
        r"E:\MiKTeX\miktex\bin\x64\lualatex.exe",
        r"E:\texlive\2026\bin\windows\lualatex.exe",
    ]
    for c in secondary_candidates:
        if os.path.isfile(c):
            return c

    return None


def clean_template_aux(template_dir: Path) -> int:
    removed = 0
    for path in template_dir.rglob("*"):
        if path.is_file() and path.suffix.lower() in AUX_EXTENSIONS:
            try:
                path.unlink()
                removed += 1
            except OSError:
                pass
    return removed


def run_check():
    console.print(Panel.fit("[bold blue]Verificação do Ambiente de Compilação Local[/bold blue]"))

    cfg = load_config()
    table = Table(title="Diagnóstico de Componentes", show_header=True, header_style="bold cyan")
    table.add_column("Componente", style="dim", width=25)
    table.add_column("Status", width=14)
    table.add_column("Detalhes")

    # 1. LuaLaTeX
    lua_bin = get_lualatex_path(cfg)
    if lua_bin:
        try:
            ver = subprocess.run([lua_bin, "--version"], capture_output=True, text=True, check=True)
            first_line = ver.stdout.splitlines()[0] if ver.stdout else "Detectado"
            table.add_row("Compilador (lualatex)", "[green]OK[/green]", f"{first_line} ({lua_bin})")
        except Exception:
            table.add_row("Compilador (lualatex)", "[green]OK[/green]", lua_bin)
    else:
        table.add_row(
            "Compilador (lualatex)",
            "[red]NÃO ENCONTRADO[/red]",
            "Necessário para compilar com fontspec e TTF local. Instale TeX Live ou MiKTeX.",
        )

    # 2. Fontes globais
    fonts_dir = ROOT_DIR / cfg.get("fonts_dir", "fonts")
    if not fonts_dir.exists():
        table.add_row("Fontes Globais", "[red]FALTANDO[/red]", f"Pasta {fonts_dir} não encontrada")
    else:
        missing_fonts = [f for f in EXPECTED_FONTS if not (fonts_dir / f).exists()]
        if missing_fonts:
            table.add_row(
                "Fontes Globais",
                "[yellow]PARCIAL[/yellow]",
                f"{len(EXPECTED_FONTS) - len(missing_fonts)}/{len(EXPECTED_FONTS)} encontradas. Faltando: {', '.join(missing_fonts)}",
            )
        else:
            table.add_row(
                "Fontes Globais",
                "[green]OK[/green]",
                f"Todas as {len(EXPECTED_FONTS)} fontes presentes em {fonts_dir.name}/",
            )

    # 3. Templates
    templates = cfg.get("templates", {})
    for key, t in templates.items():
        tdir = ROOT_DIR / t["directory"]
        entry = tdir / t["entrypoint"]
        if entry.exists():
            table.add_row(f"Template '{key}'", "[green]OK[/green]", f"{t['name']} -> {entry.relative_to(ROOT_DIR)}")
        else:
            table.add_row(f"Template '{key}'", "[red]ERRO[/red]", f"Arquivo não encontrado: {entry}")

    console.print(table)

    if not lua_bin:
        console.print("\n[bold yellow]Como instalar o compilador LaTeX no Windows:[/bold yellow]")
        console.print("  [white]Opção 1 - Via winget (recomendado):[/white]")
        console.print("    [cyan]winget install --id TeXLive.TeXLive[/cyan]    (TeX Live completo)")
        console.print("    [cyan]winget install MiKTeX.MiKTeX[/cyan]           (MiKTeX rápido com auto-download)")
        console.print("  [white]Opção 2 - Download oficial:[/white]")
        console.print("    TeX Live: https://www.tug.org/texlive/windows.html")
        console.print("    MiKTeX:   https://miktex.org/download")
        console.print("  [white]Após instalar, reinicie o terminal ou PowerShell para atualizar o PATH.[/white]")


def run_list():
    cfg = load_config()
    out_dir = cfg.get("output_dir", "dist")

    table = Table(title="Templates de Relatório Disponíveis", show_header=True, header_style="bold magenta")
    table.add_column("Chave", style="bold cyan", width=12)
    table.add_column("Nome", width=14)
    table.add_column("Pasta", width=12)
    table.add_column("Arquivo Fonte", width=18)
    table.add_column("Saída Final (PDF)", width=24)
    table.add_column("Passadas", width=10)
    table.add_column("Descrição")

    for key, t in cfg.get("templates", {}).items():
        table.add_row(
            key,
            t["name"],
            t["directory"],
            t["entrypoint"],
            f"{out_dir}/{t['output_name']}",
            str(t.get("passes", 1)),
            t.get("description", ""),
        )

    console.print(table)


def run_clean(clean_all: bool = False):
    cfg = load_config()
    total_removed = 0

    for _, t in cfg.get("templates", {}).items():
        tdir = ROOT_DIR / t["directory"]
        if tdir.exists():
            count = clean_template_aux(tdir)
            total_removed += count

    console.print(f"[green]Arquivos auxiliares removidos: {total_removed}[/green]")

    if clean_all:
        out_dir = ROOT_DIR / cfg.get("output_dir", "dist")
        if out_dir.exists():
            shutil.rmtree(out_dir)
            console.print(f"[yellow]Pasta de saída {out_dir.name}/ removida.[/yellow]")


def compile_single_template(
    key: str,
    t_info: Dict[str, Any],
    out_dir_path: Path,
    clean_aux: bool,
    override_passes: Optional[int],
    verbose: bool,
) -> bool:
    name = t_info["name"]
    tdir = ROOT_DIR / t_info["directory"]
    entrypoint = tdir / t_info["entrypoint"]
    output_name = t_info["output_name"]
    passes = override_passes if override_passes is not None else t_info.get("passes", 1)

    if not entrypoint.exists():
        console.print(f"[red]Erro:[/red] Arquivo de entrada {entrypoint} não existe.")
        return False

    cfg = load_config()
    lualatex = get_lualatex_path(cfg)
    if not lualatex:
        console.print(
            "[bold red]Erro crítico:[/bold red] O compilador [bold]lualatex[/bold] não foi encontrado no PATH.\n"
            "Instale o TeX Live (`winget install --id TeXLive.TeXLive`) ou MiKTeX (`winget install MiKTeX.MiKTeX`)."
        )
        return False

    console.print(f"\n[bold cyan]Compilando:[/bold cyan] {name} ({key})")
    console.print(f"  Origem:    {entrypoint.relative_to(ROOT_DIR)}")
    console.print(f"  Passadas:  {passes}")

    start_time = time.time()

    for pass_num in range(1, passes + 1):
        if passes > 1:
            console.print(f"  -> Passada {pass_num}/{passes}...", style="dim")

        cmd = [
            lualatex,
            "--interaction=nonstopmode",
            "--halt-on-error",
            entrypoint.name,
        ]

        result = subprocess.run(
            cmd,
            cwd=tdir,
            capture_output=True,
            text=True,
        )

        if result.returncode != 0:
            console.print(f"[bold red]Falha na compilação ({name})![/bold red]")
            log_file = tdir / f"{entrypoint.stem}.log"
            if log_file.exists():
                console.print(f"[yellow]Detalhes do erro ({log_file.name}):[/yellow]")
                with open(log_file, "r", encoding="utf-8", errors="replace") as f:
                    lines = f.readlines()
                    error_lines = [line.strip() for line in lines if line.startswith("!") or "Error" in line]
                    if error_lines:
                        for el in error_lines[-5:]:
                            console.print(f"  [red]{el}[/red]")
                    else:
                        for l in lines[-15:]:
                            console.print(f"  {l.strip()}")
            else:
                console.print(result.stdout[-1000:])
            return False

    source_pdf = tdir / f"{entrypoint.stem}.pdf"
    if not source_pdf.exists():
        console.print(f"[red]Erro:[/red] PDF não encontrado em {source_pdf}")
        return False

    out_dir_path.mkdir(parents=True, exist_ok=True)
    target_pdf = out_dir_path / output_name
    shutil.copy2(source_pdf, target_pdf)

    elapsed = time.time() - start_time
    size_mb = target_pdf.stat().st_size / (1024 * 1024)

    console.print(
        f"[bold green]✔ Sucesso![/bold green] PDF gerado em: "
        f"[bold white]{target_pdf.relative_to(ROOT_DIR)}[/bold white] "
        f"({size_mb:.2f} MB, {elapsed:.1f}s)"
    )

    if clean_aux:
        cleaned = clean_template_aux(tdir)
        if verbose:
            console.print(f"  Limpeza: {cleaned} arquivos auxiliares removidos em {tdir.name}/", style="dim")

    return True


def run_build(
    target: str = "all",
    out_dir: Optional[str] = None,
    clean: Optional[bool] = None,
    passes: Optional[int] = None,
    verbose: bool = False,
):
    cfg = load_config()

    output_dir_str = out_dir or cfg.get("output_dir", "dist")
    out_dir_path = ROOT_DIR / output_dir_str
    clean_aux = clean if clean is not None else cfg.get("clean_aux_after_build", True)

    templates = cfg.get("templates", {})

    target_key = target.lower().strip()
    if target_key in ("all", "", "build"):
        keys_to_build = list(templates.keys())
    elif target_key in templates:
        keys_to_build = [target_key]
    else:
        matched = [k for k in templates if target_key in k.lower() or target_key in templates[k]["name"].lower()]
        if matched:
            keys_to_build = matched
        else:
            console.print(f"[bold red]Template '{target}' não reconhecido.[/bold red]")
            console.print(f"Opções disponíveis: all, {', '.join(templates.keys())}")
            sys.exit(1)

    console.print(Panel.fit(f"[bold]Iniciando compilação dos relatórios ({len(keys_to_build)} selecionados)[/bold]"))

    success_count = 0
    for key in keys_to_build:
        ok = compile_single_template(
            key=key,
            t_info=templates[key],
            out_dir_path=out_dir_path,
            clean_aux=clean_aux,
            override_passes=passes,
            verbose=verbose,
        )
        if ok:
            success_count += 1

    console.print("\n" + "=" * 60)
    if success_count == len(keys_to_build):
        console.print(
            f"[bold green]Concluído com sucesso:[/bold green] {success_count}/{len(keys_to_build)} PDFs prontos em [bold]{out_dir_path.name}/[/bold]."
        )
    else:
        console.print(
            f"[bold yellow]Aviso:[/bold yellow] {success_count}/{len(keys_to_build)} compilados com sucesso. Verifique as mensagens acima."
        )


@click.command(
    name="build",
    context_settings={"ignore_unknown_options": True, "allow_extra_args": True},
)
@click.argument("action_or_template", default="all", required=False)
@click.option("-o", "--out-dir", default=None, help="Diretório de destino dos PDFs (padrão: dist/).")
@click.option("--clean/--no-clean", default=None, help="Limpar arquivos auxiliares após o build.")
@click.option("--passes", default=None, type=int, help="Forçar quantidade de passadas de compilação.")
@click.option("-v", "--verbose", is_flag=True, help="Exibe detalhes adicionais do processo.")
@click.option("--check", is_flag=True, help="Executa diagnóstico dos pré-requisitos do ambiente.")
@click.option("--list", "list_flag", is_flag=True, help="Lista os templates disponíveis.")
def cli(
    action_or_template: str,
    out_dir: Optional[str],
    clean: Optional[bool],
    passes: Optional[int],
    verbose: bool,
    check: bool,
    list_flag: bool,
):
    """Compila os templates LaTeX para PDF.

    Comandos e ações:
      uv run build              -> Compila todos os relatórios para a pasta dist/
      uv run build apostila     -> Compila somente o Guia Rápido (Apostila)
      uv run build flyer        -> Compila somente o Flyer A3
      uv run build onepage      -> Compila somente o OnePage LG
      uv run build check        -> Verifica LuaLaTeX, fontes e dependências
      uv run build clean        -> Limpa arquivos auxiliares (.aux, .log, .toc, etc.)
      uv run build list         -> Lista templates e rotas de saída configuradas
    """
    arg = action_or_template.lower().strip()

    if check or arg == "check":
        run_check()
    elif list_flag or arg == "list":
        run_list()
    elif arg == "clean":
        run_clean(clean_all=False)
    elif arg == "clean-all":
        run_clean(clean_all=True)
    else:
        run_build(
            target=arg,
            out_dir=out_dir,
            clean=clean,
            passes=passes,
            verbose=verbose,
        )


if __name__ == "__main__":
    cli()
