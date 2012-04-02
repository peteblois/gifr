#include "gifrmodule.h"

namespace gifr {

GifrModule::GifrModule() : pp::Module() {
    printf("Got here.\n");
  }

pp::Instance* GifrModule::CreateInstance(PP_Instance instance) {
  return new GifrInstance(instance);
}

}  // namespace gifr
