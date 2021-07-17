## What this project does

### The Python and rust part:

This project is building on the 2017 experiment at https://developers.redhat.com/blog/2017/11/16/speed-python-using-rust/  

Just like in that blog post, I am building a pure python counter of pairs of repeated chars, a python regex implementation, and a Rust library with python wrappers using https://github.com/dgrunwald/rust-cpython 

### The f21-nixpkgs part:
This project builds a reproducible environment combining a `rust 1.41.0-nightly` with python3.
In this case I am incorporating this with a local nix development setup, and an upstream `*-nixpkgs` which is a custom subset of the nixpkgs repository that in turn inherits and uses `nixpkgs` ( see https://github.com/NixOS/nixpkgs ).

Eventually, this project itself can become a package in the upstream f21-nixpkgs that it inherits.  

### The results

As you can see below, using Rust in python makes the same operation 10x faster than Python Regex, and 21x faster than pure Python!

In addition, the nixpkgs approach allows us to build and deploy this anywhere, and to create a reproducable local environment for development on the target Nixos OS (this could also be deployed to macOs or Windows with a bit of work. Anywhere that you can install Nix package manager).

```
[nix-shell:~/Desktop/python-rust]$ pytest counting.py 
======================================================== test session starts ========================================================
platform linux -- Python 3.7.4, pytest-4.6.3, py-1.7.0, pluggy-0.12.0
benchmark: 3.2.2 (defaults: timer=time.perf_counter disable_gc=False min_rounds=5 min_time=0.000005 max_time=1.0 calibration_precision=10 warmup=False warmup_iterations=100000)
rootdir: /home/samrose/Desktop/python-rust
plugins: benchmark-3.2.2
collected 3 items                                                                                                                   

counting.py ...                                                                                                               [100%]


--------------------------------------------------------------------------------- benchmark: 3 tests ---------------------------------------------------------------------------------
Name (time in ms)         Min                Max               Mean            StdDev             Median               IQR            Outliers       OPS            Rounds  Iterations
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
test_rust              1.7867 (1.0)       2.1184 (1.0)       1.8208 (1.0)      0.0341 (1.0)       1.8188 (1.0)      0.0512 (1.0)          67;3  549.2015 (1.0)         535           1
test_regex            21.4615 (12.01)    30.0339 (14.18)    22.8539 (12.55)    2.2623 (66.25)    22.1458 (12.18)    0.7071 (13.81)         5;6   43.7561 (0.08)         46           1
test_pure_python      46.3501 (25.94)    53.8999 (25.44)    47.1186 (25.88)    1.4972 (43.84)    46.8384 (25.75)    0.3294 (6.43)          1;1   21.2230 (0.04)         23           1
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Legend:
  Outliers: 1 Standard Deviation from Mean; 1.5 IQR (InterQuartile Range) from 1st Quartile and 3rd Quartile.
  OPS: Operations Per Second, computed as 1 / Mean
===================================================== 3 passed in 4.98 seconds ======================================================
```


### Next steps

The next step will be to use this approach in some django project apps to cut down execution time of complex math and image processing operations. And, to wire up a https://github.com/NixOS/hydra build farm to manage builds for distributed nodes running this software.
