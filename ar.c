#include <stdio.h>

char *binarymkdir = "/usr/bin/mkdir";
char *binaryloadkeys = "/usr/bin/loadkeys";
int uefi = 0;

int adminDiscos()
{
	printf("discos");
}

int main()
{		
		// loadkeys es
		char *lan = "es";
		printf("Eh: %d", execl(binaryloadkeys, binaryloadkeys, lan, NULL));

		adminDiscos();

        return 0;
}