public class Helper {
    
    public static String phoneNumberNumericText(String phoneNumberText){
        return phoneNumberText.replaceAll('[^0-9]', '');
    }
    
    public static String phoneNumber10NumericAfterLeading1or0(String phoneNumberText){     
        if(phoneNumberText == NULL) return null;
        String newPhoneNumberText = phoneNumberText.replaceAll('[^0-9]', '');
        While (newPhoneNumberText.length()>1 && (newPhoneNumberText.Left(1)=='1' || newPhoneNumberText.Left(1)=='0')){
            newPhoneNumberText = newPhoneNumberText.mid(1, 10);
        }
        return newPhoneNumberText;
    }    

}