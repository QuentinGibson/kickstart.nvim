public class TestJava {
  public static void main(String[] args) {
    System.out.println("Hello, Java!");

    // Test LSP features
    String message = "Testing Java LSP";
    int length = message.length();

    if (length > 0) {
      System.out.println("Message: " + message);
      System.out.println("Length: " + length);
    }
  }

  private void helperMethod() {
    // This should show up in document symbols
  }
}
