#include <stdio.h>

int main(){
	//index counter of 1D array
	int index=0; 
	// initializing 1D array
	int arr1D[36];
	int sample_size = 3; // temp: 3, but must ask user for 3, 5, or 9
	// initializing matrix
	int matrix[6][6] = {
      {1, 4, 0, 1, 3, 1},
      {2, 2, 4, 2, 2, 3},
      {1, 0, 1, 0, 1, 0},
	  {1, 2, 1, 0, 2, 2},
	  {2, 5, 3, 1, 2, 5},
	  {1, 1, 4, 2, 3, 0}
    };
	
	//convert 2d array to 1d array
	
		for(int x=0; x<6; x++){
			for(int y=0; y<6; y++){
				arr1D[index]=matrix[x][y];
				index++;
			}
		}
	
	// for checking if correct conversion
	printf("1D Array: ");

	for (int i = 0; i < 36; ++i) {
		printf("%d ", arr1D[i]);
	}
	printf("\n");
	printf("%d ", arr1D[4]);
	
	return 0;
}