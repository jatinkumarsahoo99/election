class ApiFactory {
  // static String BASEURL="http://4.188.234.4:5002";
  static String BASEURL="https://election.nishitasolutions.in/";

  // static String BASEURL2="http://4.188.234.4:3000";
  static String BASEURL2="http://192.168.0.162:3000";

  static String LOGIN ="${BASEURL}allapilists?action=logincredn&";
  static String GET_DISTRICT ="${BASEURL}allapilists?action=getdistricts&state_id=";
  static String GET_ASSEMBLY_CONSTINUENCY ="${BASEURL}allapilists?action=assembly_constinuency&district_id=";
  static String GET_USER_DETAILS ="${BASEURL}allapilists?action=searchvoterlist&state_id=1&district_id=1&assembly_id=2";
}