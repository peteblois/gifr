#include "gifrinstance.h"

#include <algorithm>

namespace gifr {

/// Method name for ReverseText, as seen by JavaScript code.
const char* const kReverseTextMethodId = "reverseText";

/// Method name for FortyTwo, as seen by Javascript code. @see FortyTwo()
const char* const kFortyTwoMethodId = "fortyTwo";

/// Separator character for the reverseText method.
static const char kMessageArgumentSeparator = ':';

GifrInstance::GifrInstance(PP_Instance instance) : pp::Instance(instance) {
  printf("GifrInstance.\n");
}

void GifrInstance::HandleMessage(const pp::Var& var_message) {
  if (!var_message.is_string()) {
    return;
  }
  std::string message = var_message.AsString();
  pp::Var return_var;
  if (message == kFortyTwoMethodId) {
    // Note that no arguments are passed in to FortyTwo.
    return_var = MarshallFortyTwo();
  } else if (message.find(kReverseTextMethodId) == 0) {
    // The argument to reverseText is everything after the first ':'.
    size_t sep_pos = message.find_first_of(kMessageArgumentSeparator);
    if (sep_pos != std::string::npos) {
      std::string string_arg = message.substr(sep_pos + 1);
      return_var = MarshallReverseText(string_arg);
    }
  }
  // Post the return result back to the browser.  Note that HandleMessage() is
  // always called on the main thread, so it's OK to post the return message
  // directly from here.  The return post is asynhronous: PostMessage returns
  // immediately.
  PostMessage(return_var);
}

pp::Var GifrInstance::MarshallFortyTwo() {
  return pp::Var(42);
}

pp::Var GifrInstance::MarshallReverseText(const std::string& text) {
  return pp::Var(ReverseText(text));
}

std::string GifrInstance::ReverseText(const std::string& text) {
  std::string reversed_string(text);
  // Use reverse to reverse |reversed_string| in place.
  std::reverse(reversed_string.begin(), reversed_string.end());
  return reversed_string;
}

}  // namespace gifr
