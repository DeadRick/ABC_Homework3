#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int64_t calculateElapsedTime(struct timespec t1, struct timespec t2) {
    int64_t ns1, ns2;

    ns1 = t1.tv_sec;
    ns1 *= 1000000000;
    ns1 += t1.tv_nsec;


    ns2 = t2.tv_sec;
    ns2 *= 1000000000;
    ns2 += t2.tv_nsec;

    return ns2 - ns1;
}

double calculateFactorial(int n)
{
	double factorial = 1;
	for (int i = 1; i <= n; i++)
	{
		factorial *= i;
	}
	return factorial;
}

double calculatePower(double x, int n)
{
	double power = 1;
	for (int i = 0; i < n; i++)
	{
		power *= x;
	}
	return power;
}

double calculateE(double x)
{
	double result = 0;
	int k = 0;
	double ak = 1;
	while (ak >= 0.05)
	{
		ak = calculatePower(x, k) / calculateFactorial(k);
		result += ak;
		k++;
	}
	return result;
}

int main()
{
    FILE *input, *output;
    struct timespec start;
    struct timespec end;
    int64_t elapsed_time;
	double x;
	
	 if (argc == 1) {
        printf("x: ");
        scanf("%lf", &x);
    } else if (argc == 2) {
        input = fopen(argv[1], "r");
        fscanf(input, "%lf", &x);
    } else if (argc == 3) {
        srand(atoi(argv[1]));
        x = (((double) rand()) / RAND_MAX) * 100.0;
        printf("Your random number: %lf\n", x);
    } else {
        return -1;
    }
    
    
    if (x < 0.0) {
        printf("x < 0.0.\n Exit \n");
        return 0;
    }
    
    clock_gettime(CLOCK_MONOTONIC, &start);
    for (int i = 0; i < 10000; i++) {
        x = calculateE(x);
    }
    clock_gettime(CLOCK_MONOTONIC, &end);
    
    if (argc == 2) {
        output = fopen(argv[2], "w");
        fprintf(output, "%lf\n", x);
        return 0;
    } 
    
    printf("Result: %lf\n", x);
	return 0;
}

