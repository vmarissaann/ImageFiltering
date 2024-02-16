De La Salle University![](dlsu.png)

Computer Technology Department

Laboratory for Computer Organization and Architecture

LBYARCH 2023-2024 Term1

Machine Project 2

Task

Develop an x86\_32 assembly function which you can call from a C program that performs average filtering on an input image.

Averaging filter is an image-processing technique that reduces the effect of salt-and-pepper noise from an image. Salt-and-pepper noise is irregularly scattered white or black pixels that degrade the quality of the image. See Figure 1



|![](unfiltered.png)|![](filtered.png)|
| - | - |
|Salt and pepper noise|Average filtered image|
|Figure 1: Average Image Filter [1]||

Image Representation

Among the different digital color spaces used to represent an image, we will only be focusing on the representation of a grayscale image. A grayscale image is digitally represented as a 2 dimensional matrix wherein each element on the matrix corresponds to a pixel in the image.



|![](matrix.png)|
| - |
|Figure 2: Matrix illustration [2]|

Suppose a 3x3 image A, the value of pixel(x,y) in Image A is represented by element axy of matrix A, see Figure 2. Each pixel can take an integer value from 0-255 which is an 8 bit unsigned integer. 0 represents black. 255 represents white. Values in between represent different scales of gray.

Average Filtering



|![](avgfilter.png)|
| - |
|Figure 3: Average Filter Illustration [3]|

To perform average filtering on an image, replace each pixel with the average value of its neighboring pixel including itself, see Figure 3. Pixels on the edges of an image do not need to be averaged.

The sampling window determines the coverage of how many pixels are considered neighbors. A size 3 sampling window is a 3x3 window wherein the target pixel is in the middle and the neighboring pixels surround the target pixel.

Input Format

A function call from C to assembly with a function name **imgAvgFilter()** with the following parameters:

**input\_image** is a 1d array that represents the 2d Matrix of image A and is already initialized from the C program.

**filtered\_image** is a 1d array that represents the 2d Matrix of the filtered image. It has the same size as input\_image. Its memory space can be allocated from the C program.

And three more integer values that determine the **image\_size\_x**, **image\_size\_y**, **sampling\_window\_size**

Output Format

The function returns the filtered image via placing the values on **filtered\_image**. Print the filtered\_image in the following format. Printing can be implemented in C.

1 2 3 4 5

6 7 8 9 10

11 12 13 14 15

16 17 18 19 20

21 22 23 24 25

Submission

Submit a working C and x86 code together with a batch file that performs the compiling, linking, and executing of your program. Also submit a screenshot with your test case displaying that your code works. Submit all the files compressed using the .zip format LBYARCH-SEC-GRP-MP02-LASTNAMES.zip.

Implementation Requirement

The average filter function must be implemented in x86\_32 assembly and has to be called from a C program. All the required files must also be submitted. Failure to comply with all of the requirements will result in a no-submission.

References

Images are taken from the following sources

1. ALhussieny (2017) Using MATLAB to Get the Best Performance with Different Type Median Filter on the Resolution Picture. Retrieved from <http://iieng.org/images/proceedings_pdf/7_D_New_formatted.pdf>
1. R Nave (n.d.) Matrices. Retrieved from <http://hyperphysics.phy-astr.gsu.edu/hbase/Math/matrix.html>
1. (2010) Image Filtering. Retrieved from [https://www.cs.auckland.ac.nz/courses/compsci373s1c/PatricesLectures/Image%20Filtering_2u p.pdf](https://www.cs.auckland.ac.nz/courses/compsci373s1c/PatricesLectures/Image%20Filtering_2up.pdf)
