# Supersinglet-GME-dimension

Multipartite systems of high-dimensional particles can host forms of quantum entanglement inaccessible to qubit systems. A particularly fascinating class is formed by the fully antisymmetric states, also known as supersinglets, which possess a remarkable symmetry: they are invariant under arbitrary collective local unitaries. Here, we explore their entanglement properties and establish their quantum information applications. Using convex optimisation, we show that central entanglement features of supersinglets are remarkably robust to noise, substantially surpassing the robustness of several paradigmatic entangled states. We then develop witness methods, based on collective-spin or randomised measurements, that certify both the depth and dimensionality of their entanglement. Finally, we identify supersinglets as a natural resource for high-dimensional gradient sensing and prove that they enable Heisenberg scaling. Together, these results reveal supersinglets as an exceptionally robust and versatile class of multipartite entangled states, combining striking symmetry and strong entanglement with concrete potential for quantum sensing.

# List of the functions
Functions to compute the symmetrised SDP for noise robustness of GME-dimension for the supersinglet state.

## GMEdimSS.m

Function to compute the symmetrised SDP for the supersinglet white noise robustness of the GME-dimension.

## cycltoperm.m

Function to convert a permutation expressed in cyclic decomposition into vector notation.

## cycle_decomp.m

Function to find the cyclic decomposition of a permutation and compute the number of cycles contained in a set S.

## rhoYoungAll.m

Function to compute the matrix representation of a given permutation p using Young's orthogonal representation.

# References

[1]: G. Cobucci, A. Tavakoli, A. Bernal, S. Khandelwal (2026). The superb supersinglet (https://arxiv.org/abs/2610.06183)

[2]: Bruno Luong (2024). Set partition (https://www.mathworks.com/matlabcentral/fileexchange/24133-set-partition), MATLAB Central File Exchange. Retrieved February 5, 2024.
