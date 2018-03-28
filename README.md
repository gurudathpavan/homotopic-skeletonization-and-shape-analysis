# homotopic-skeletonization-and-shape-analysis
## 1 Homotopic skeletonization
Apply homotopic skeletonization to obtain the skeleton of the "penn256" and "bear" images. Give the results of the algorithm
for X2, X5, X10, and the final skeletonized image. Show each result as a superposition of X_i on the original image.
## 2 Shape Analysis 
For both parts below, let B be the 33 square. Also, for each considered image, you will need to isolate distinct objects and find the minimum bounding rectangle (MBR) (also referred to as the bounding box) enclosing each distinct object. Feel free to use the MatLab connected-component labeling function to help with this.
(a) Consider the "match1" image, which contains 4 objects (clover, spade, steer, and airplane).
i. Compute the size distribution, pectrum, and complexity of each object. Give well labeled plots and/or tables, as appropriate, for your results. Which object is the most complex? You must give quantitative results to back up your answer.
ii. Now, consider image "match3," which contains rotated versions of the objects in "match1." Use pecstral analysis, as discussed in P&V Section 6.11 and the Lecture 6 notes, to determine which object in "match3" best matches the \spade" (upper right object) in "match1." Be sure to give all necessary pecstral and distance calculations in your report, in addition to the specific algorithm you use.

(b) Consider the image "shadow1," which has four solid objects; the objects are characters from the "Peanuts" comic strip. Quantitatively (and automatically) match them to the proper objects depicted in the complementary image "shadow1rotated." Give sufficient results to make it perfectly clear how you arrived at your results.

## Report
Write a detailed report describing your results and implementations. 

# Run 

-main_skele.m for homotopic skeletonization
-main_shape2a.m for shape analyis of match1.gif and match3.gif
-main_shape2b.m for shape analysis of shadow1.gif and shadow1rotated.gif


Keep MATLAB working command on the same working directory as this project files
All images will be saved in the current working directory

