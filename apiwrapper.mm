#include "apiwrapper.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIApplication.h>

void ApiWrapper::setTimerDisabled()
{
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
}

void ApiWrapper::setTimerEnabled()
{
    [[UIApplication sharedApplication] setIdleTimerDisabled: NO];
}
