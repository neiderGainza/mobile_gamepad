#pragma once

#include <ViGEm/Client.h>

#ifdef __cplusplus
extern "C" {
#endif

__declspec(dllexport)
PVIGEM_CLIENT my_vigem_alloc(void);

__declspec(dllexport)
VIGEM_ERROR my_vigem_connect(
    PVIGEM_CLIENT client
);

__declspec(dllexport)
void my_vigem_disconnect(
    PVIGEM_CLIENT client
);

__declspec(dllexport)
void my_vigem_free(
    PVIGEM_CLIENT client
);

__declspec(dllexport)
PVIGEM_TARGET my_vigem_target_x360_alloc(void);

__declspec(dllexport)
VIGEM_ERROR my_vigem_target_add(
    PVIGEM_CLIENT client,
    PVIGEM_TARGET target
);

__declspec(dllexport)
VIGEM_ERROR my_vigem_target_x360_update(
    PVIGEM_CLIENT client,
    PVIGEM_TARGET target,
    XUSB_REPORT report
);

__declspec(dllexport)
void my_vigem_target_remove(
    PVIGEM_CLIENT client,
    PVIGEM_TARGET target
);

__declspec(dllexport)
void my_vigem_target_free(
    PVIGEM_TARGET target
);

#ifdef __cplusplus
}
#endif