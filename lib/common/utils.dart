String handleProviderModel(String selectedProvider) {
  if (selectedProvider == 'OpenAi') {
    return "gpt-3.5-turbo";
  }
  if (selectedProvider == 'Groq') {
    return "mixtral-8x7b-32768";
  }
  else {
    return "";
  }
}
