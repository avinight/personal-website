
profiling
- `valgrind --tool=cachegrind ./mm` or perf
# Optimizations
- Loop order switching
- `O0`, `O1`, `O2`, `O3`
- `#pragma omp parallel for`, `cilk_for`
- Tiling, vectorization, matrix transposition, data alignment, preprocessing, AVX instructions