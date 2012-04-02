// #ifndef INCLUDED_GIFR_MODULE_H
// #define INCLUDED_GIFR_MODULE_H

#include "ppapi/cpp/module.h"
#include "gifrinstance.h"

namespace gifr {

class GifrModule : public pp::Module {
 public:
  GifrModule();
  virtual ~GifrModule() {}

  /// Create and return a HelloWorldInstance object.
  /// @param[in] instance a handle to a plug-in instance.
  /// @return a newly created HelloWorldInstance.
  /// @note The browser is responsible for calling @a delete when done.
  virtual pp::Instance* CreateInstance(PP_Instance instance);
};
}  // namespace gifr


namespace pp {
/// Factory function called by the browser when the module is first loaded.
/// The browser keeps a singleton of this module.  It calls the
/// CreateInstance() method on the object you return to make instances.  There
/// is one instance per <embed> tag on the page.  This is the main binding
/// point for your NaCl module with the browser.
/// @return new HelloWorldModule.
/// @note The browser is responsible for deleting returned @a Module.
Module* CreateModule() {
  return new gifr::GifrModule();
}
}  // namespace pp

//#endif // INCLUDED_GIFR_MODULE_H
