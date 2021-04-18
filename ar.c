#include <stdio.h>

char *binarymkdir = "/usr/bin/mkdir";
char *binaryloadkeys = "/usr/bin/loadkeys";

int main()
{		
		// loadkeys es
		char *lan = "es";
		execl(binaryloadkeys, binaryloadkeys, lan, NULL);

        return 0;
}