# Martin Starič

## Matematično nihalo


Projekt vsebuje funkcije, ki rešijo diferencialne enačbe za matematično in harmonično nihalo.

### Zaganjanje kode

Kodo zaženemo tako da:

1. **Aktiviramo okolje:**
   - Odpri Julia REPL in pojdi v način pkg tako da napišeš `]`.
   - Aktiviraj okolje z ukazom:
     ```julia
     activate DN3
     ```

2. **Uporaba kode:**
   - Sledi primeru v `\test\demo.jl`.

3. **Testi:**
    - Testi so napisani v `\test\runtests.jl`. Zaenkrat so testi prazni.

### Generiranje .tex datoteke

`.tex` datoteka je generirana s skripto `\docs\makedoc.jl`, ki uporablja paket `Weave.jl` v tem direktoriju se nahaja tudi poročilo.

