#include "vigem_bridge.h"
#include <unordered_map>

using namespace std;

static unordered_map<PVIGEM_TARGET, RumbleState> rumbleStates = {};


extern "C" {

__declspec(dllexport)
PVIGEM_CLIENT my_vigem_alloc(void){
    return vigem_alloc();
}


__declspec(dllexport)
VIGEM_ERROR my_vigem_connect(
    PVIGEM_CLIENT client
)
{

    return vigem_connect(client);
}


__declspec(dllexport)
void my_vigem_disconnect(
    PVIGEM_CLIENT client
){
    vigem_disconnect(client);
}


__declspec(dllexport)
void my_vigem_free(
    PVIGEM_CLIENT client
){
    vigem_free(client);
}


__declspec(dllexport)
PVIGEM_TARGET my_vigem_target_x360_alloc(void)
{   
    return vigem_target_x360_alloc();
}


void CALLBACK RumbleCallback(
    PVIGEM_CLIENT,
    PVIGEM_TARGET target,
    UCHAR x,
    UCHAR y,
    UCHAR,
    LPVOID
){
    rumbleStates[target].largeMotor = x;
    rumbleStates[target].smallMotor = y;
}

__declspec(dllexport)
VIGEM_ERROR my_vigem_target_add(
    PVIGEM_CLIENT client,
    PVIGEM_TARGET target
){
    VIGEM_ERROR error = vigem_target_add(client, target);
    
    if (!VIGEM_SUCCESS(error)){
        return error;
    }

    rumbleStates[target] = {};
    
    vigem_target_x360_register_notification(
        client,
        target,
        RumbleCallback,
        nullptr
    );

    return error;
}



__declspec(dllexport)
RumbleState my_vigem_target_get_rumble(
    PVIGEM_TARGET target
){
    return rumbleStates[target];
}



__declspec(dllexport)
VIGEM_ERROR my_vigem_target_x360_update(
    PVIGEM_CLIENT client,
    PVIGEM_TARGET target,
    XUSB_REPORT report
){
    return vigem_target_x360_update(
        client,
        target,
        report
    );
}


__declspec(dllexport)
void my_vigem_target_remove(
    PVIGEM_CLIENT client,
    PVIGEM_TARGET target
){
    vigem_target_remove(client, target);
}


__declspec(dllexport)
void my_vigem_target_free(
    PVIGEM_TARGET target
){
    rumbleStates.erase(target);
    vigem_target_free(target);
}








}