/* WARNING: Type propagation algorithm not settling */

void phase_6(undefined4 param_1)
{
  int *p1;
  int i;
  int *p3;
  int j;
  int *arr;
  int *res[6];
  int nums[6];
  
  // arr = [ 253,   0,   0,   0,   1,   0,   0,   0,   96,   178,   4,   8 ]; 
  arr =    [ 0xfd, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x60, 0xb2, 0x04, 0x08 ]; // Some data
  read_six_numbers(param_1,nums);

  // Check if there 6 numbers with different values
  j = 0;
  do {
    i = j;
    if (nums[j] >= 6) {
      explode_bomb();
    }
    while (i = i + 1, i < 6) {
      if (nums[j] == nums[i]) {
        explode_bomb();
      }
    }
    j = j + 1;
  } while (j < 6);

  // 4
  j = 0;
  do {
    i = 1;
    p3 = (int *)[ 0xfd, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x60, 0xb2, 0x04, 0x08 ];

    if (nums[j] >= 1) {
      do {
        p3 = (int *)p3[2]; // p3 = p3 + 2 (2 * i times)
        i = i + 1;
      } while (i < nums[j]);
    }
    res[j] = p3;
    j = j + 1;
  } while (j < 6);

  // res[0] = &arr[6];
  // res[1] = 


  j = 1;
  p3 = res[0];
  do {
    
    p1 = res[j];
    p3[2] = (int)p1;
    j = j + 1;
    p3 = p1;

  } while (j < 6);

  
  p1 = res[j];
  p3[2] = (int)p1;
  j = j + 1;
  p3 = p1;



  p1[2] = 0;
  j = 0;
  do {
    if (*res[0] < *(int *)res[0][2]) {
      explode_bomb();
    }
    res[0] = (int *)res[0][2];
    j = j + 1;
  } while (j < 5);


  return ;
}