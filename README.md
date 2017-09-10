# StereoMatching
implementation of some basical stereo matching mathods:

![Result](https://github.com/galad-loth/StereoMatching/blob/master/data/result.jpg)

## Stereo match cost computation
1. absolute differences
2. Squared difference
3. truncated absolute differences
4. truncated squared differences
5. normalized cross-correlation
6. hierachical mutual information

## cost aggregation
1. fixed window based
2. shiftable window based
3. segmentation based
4. bilateral filtering based

## disparity optimization
1. graph cut based
2. scanline optimization
3. semi-global matching


## references

[1] Scharstein D, Szeliski R. A taxonomy and evaluation of dense two-frame stereo correspondence algorithms[J]. International journal of computer vision, 2002, 47(1-3): 7-42.

[2] Hirschmuller H, Scharstein D. Evaluation of cost functions for stereo matching[C]//Computer Vision and Pattern Recognition, 2007. CVPR'07. IEEE Conference on. IEEE, 2007: 1-8.

[3] Hirschmuller H. Stereo processing by semiglobal matching and mutual information[J]. IEEE Transactions on pattern analysis and machine intelligence, 2008, 30(2): 328-341.

[4] Stefano Mattoccia, Stereo Vision:Algorithms and Applications. http://www.vision.deis.unibo.it/smatt

[5] Boykov Y, Veksler O, Zabih R. Fast approximate energy minimization via graph cuts[J]. IEEE Transactions on pattern analysis and machine intelligence, 2001, 23(11): 1222-1239.

