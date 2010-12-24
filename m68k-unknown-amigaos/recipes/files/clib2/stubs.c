#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "stdlib_headers.h"

pid_t wait(int *status)
{
	__set_errno(ECHILD);

	return -1;
}

pid_t vfork(void)
{
	__set_errno(EAGAIN);

	return -1;
}

int pipe(int pipefd[2])
{
	__set_errno(ENFILE);

	return -1;
}

