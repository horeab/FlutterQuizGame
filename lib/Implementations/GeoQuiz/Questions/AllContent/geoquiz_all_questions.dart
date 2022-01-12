import 'dart:collection';

import 'package:flutter_app_quiz_game/Game/Question/Model/category_difficulty.dart';
import 'package:flutter_app_quiz_game/Game/Question/Model/question.dart';
import 'package:flutter_app_quiz_game/Game/Question/all_questions_service.dart';
import 'package:flutter_app_quiz_game/Implementations/GeoQuiz/Constants/geoquiz_game_question_config.dart';
import 'package:flutter_app_quiz_game/Lib/Constants/language.dart';
import 'package:flutter_app_quiz_game/Lib/Extensions/map_extension.dart';

class GeoQuizAllQuestions extends AllQuestionsService {
  List<String>? _allCountriesCache;
  List<String>? _allCapitalsCache;
  List<String>? _allSynonymsCache;
  List<CountryRanges>? _allCountryRanges;

  static final GeoQuizAllQuestions singleton = GeoQuizAllQuestions.internal();

  factory GeoQuizAllQuestions() {
    return singleton;
  }

  List<String> get allCapitals {
    _allCapitalsCache ??=
        _getAllCapitals().get<Language, List<String>>(getLanguage()) ??
            _getAllCapitals().get<Language, List<String>>(Language.en);
    return _allCapitalsCache!;
  }

  List<String> get allCountries {
    _allCountriesCache ??=
        _getAllCountries().get<Language, List<String>>(getLanguage()) ??
            _getAllCountries().get<Language, List<String>>(Language.en);
    return _allCountriesCache!;
  }

  List<String> get allSynonyms {
    _allSynonymsCache ??=
        _getAllSynonyms().get<Language, List<String>>(getLanguage()) ??
            _getAllSynonyms().get<Language, List<String>>(Language.en);
    return _allSynonymsCache!;
  }

  GeoQuizAllQuestions.internal();

  @override
  Map<Language, Map<CategoryDifficulty, List<Question>>>
  getAllQuestionsWithLanguages() {
    Map<Language, Map<CategoryDifficulty, List<Question>>> result =
    HashMap<Language, Map<CategoryDifficulty, List<Question>>>();
    //
    ////
    ///////
    var questionConfig = GeoQuizGameQuestionConfig();
    ///////
    ////
    //
    addEN(result, questionConfig);
    addRO(result, questionConfig);
    return result;
  }

  List<CountryRanges> get allCountryRanges {
    _allCountryRanges ??= [
      CountryRanges(0, 16, 0, 28),
      CountryRanges(17, 21, 0, 28),
      CountryRanges(22, 28, 0, 28),
      CountryRanges(29, 31, 29, 44),
      CountryRanges(32, 44, 29, 44),
      CountryRanges(45, 55, 45, 68),
      CountryRanges(56, 62, 45, 68),
      CountryRanges(63, 68, 45, 68),
      CountryRanges(69, 75, 69, 90),
      CountryRanges(76, 85, 69, 90),
      CountryRanges(86, 90, 69, 90),
      CountryRanges(91, 105, 91, 105),
      CountryRanges(106, 110, 106, 159),
      CountryRanges(111, 147, 106, 159),
      CountryRanges(148, 154, 106, 159),
      CountryRanges(155, 159, 106, 159),
      CountryRanges(160, 162, 160, 174),
      CountryRanges(163, 174, 160, 174),
      CountryRanges(175, 182, 175, 194),
      CountryRanges(183, 194, 175, 194) ];
    return _allCountryRanges!;
  }
  Map<Language, List<String>> _getAllCountries() {
    Map<Language, List<String>> result = HashMap<Language, List<String>>();
    result.putIfAbsent(Language.en, () => _allCountriesEN());
    result.putIfAbsent(Language.ro, () => _allCountriesRO());
    return result;
  }
  List<String> _allCountriesEN() {
    return ["Germany","France","United Kingdom","Spain","Italy","Belgium","Austria","Portugal","Switzerland","Netherlands","Ireland","Monaco","Luxembourg","Liechtenstein","Andorra","San Marino","Vatican City","Sweden","Denmark","Finland","Norway","Iceland","Poland","Greece","Croatia","Hungary","Slovenia","Slovakia","Czech Republic","Estonia","Latvia","Lithuania","Ukraine","Russia","Romania","Bulgaria","Serbia","Bosnia and Herzegovina","Albania","Montenegro","Belarus","Moldova","North Macedonia","Cyprus","Malta","Iran","Turkey","Iraq","Israel","Georgia","Armenia","Azerbaijan","Syria","Jordan","Lebanon","Palestine","Saudi Arabia","United Arab Emirates","Qatar","Yemen","Oman","Kuwait","Bahrain","Kazakhstan","Afghanistan","Uzbekistan","Tajikistan","Kyrgyzstan","Turkmenistan","India","Pakistan","Nepal","Sri Lanka","Bangladesh","Bhutan","Maldives","Thailand","Indonesia","Vietnam","Malaysia","Philippines","Singapore","Myanmar","Laos","Cambodia","Brunei","China","Japan","South Korea","North Korea","Mongolia","Australia","New Zealand","Papua New Guinea","East Timor","Fiji","Solomon Islands","Vanuatu","Samoa","Kiribati","Micronesia","Tonga","Marshall Islands","Palau","Nauru","Tuvalu","Egypt","Algeria","Morocco","Tunisia","Libya","Nigeria","Ghana","Senegal","Mali","Cameroon","Uganda","Ivory Coast","Angola","Tanzania","Niger","Central African Republic","Democratic Republic of the Congo","Burkina Faso","Madagascar","Chad","Mozambique","Zambia","Benin","Guinea","Togo","Rwanda","Malawi","Burundi","Liberia","Zimbabwe","Sierra Leone","Gambia","Mauritania","Gabon","Congo","Guinea-Bissau","Equatorial Guinea","Mauritius","Seychelles","Comoros","Cape Verde","São Tomé and Príncipe","Somalia","Kenya","Ethiopia","Sudan","South Sudan","Eritrea","Djibouti","South Africa","Namibia","Botswana","Lesotho","Eswatini","United States","Canada","Mexico","Cuba","Guatemala","Costa Rica","Belize","Bahamas","Jamaica","Haiti","Dominican Republic","Panama","El Salvador","Nicaragua","Honduras","Saint Lucia","Grenada","Dominica","Trinidad and Tobago","Barbados","Saint Vincent and the Grenadines","Antigua and Barbuda","Saint Kitts and Nevis","Brazil","Argentina","Colombia","Chile","Peru","Venezuela","Ecuador","Uruguay","Bolivia","Paraguay","Guyana","Suriname"];
  }
  List<String> _allCountriesRO() {
    return ["China","India","Statele Unite","Brazilia","Rusia","Mexic","Japonia","Iran","Germania","Turcia","Franţa","Regatul Unit","Tailanda","Italia","Egipt","Africa de Sud","Coreea de Sud","Spania","Argentina","Belgia","Ucraina","Polonia","Canada","Austria","Elveţia","Olanda","Indonezia","Grecia","Portugalia","Australia","Columbia","Algeria","Croaţia","Maroc","Vietnam","Suedia","Nigeria","Chile","Ungaria","România","Arabia Saudită","Bulgaria","Danemarca","Finlanda","Irlanda","Norvegia","Serbia","Malaezia","Peru","Georgia","Cuba","Ghana","Kazahstan","Irak","Afganistan","Israel","Islanda","Bosnia si Hertegovina","Armenia","Slovenia","Noua Zeelanda","Albania","Slovacia","Venezuela","Republica Cehă","Ecuador","Senegal","Nepal","Somalia","Azerbaidjan","Tunisia","Mongolia","Pakistan","Filipine","Sri Lanka","Kenia","Cambogia","Lituania","Mali","Muntenegru","Bielorusia","Camerun","Uzbekistan","Myanmar","Uruguay","Jamaica","Bolivia","Uganda","Coasta de Fildes","Cipru","Madagascar","Haiti","Angola","Qatar","Coreea de Nord","Tanzania","Yemen","Niger","Etiopia","Costa Rica","Siria","Iordania","Republica Dominicana","Emiratele Arabe Unite","Honduras","Tadjikistan","Monaco","Ciad","Mozambic","Estonia","Singapore","Zambia","Benin","Papua Noua Guinee","Guineea","Togo","Paraguay","Laos","Bangladesh","Rwanda","Burkina Faso","Libia","Liban","Kârgâzstan","Turkmenistan","Malawi","Sudan","Republica Centrafricană","Palestina","Republica Democrata din Congo","Oman","Liechtenstein","Guatemala","Sudul Sudanului","Burundi","Liberia","Zimbabwe","Kuweit","Panama","Sierra Leone","Luxemburg","Eritreea","San Marino","Moldova","Namibia","Gambia","Mauritania","Botswana","Gabon","Congo","Macedonia de Nord","Lesotho","Letonia","Guineea-Bissau","Bahrain","Guineea Ecuatorială","Timorul de Est","Trinidad și Tobago","Mauritius","Djibouti","Eswatini","Comore","Fiji","Guyana","El Salvador","Nicaragua","Bhutan","Insulele Solomon","Surinam","Republica Capului Verde","Malta","Brunei","Belize","Bahamas","Maldive","Vanuatu","Vatican","Barbados","Sao Tome și Principe","Samoa","Sfânta Lucia","Kiribati","Grenada","Sfântul Vincent și Grenadine","Micronezia","Tonga","Seychelles","Antigua si Barbuda","Andorra","Dominica","Insulele Marshall","Saint Kitts și Nevis","Palau","Nauru","Tuvalu"];
  }
  List<String> get allCountriesRanked =>
     ["0:3","1:6","2:4","3:13","4:7","5:23","6:26","7:46","8:17","9:16","10:27","11:148","12:68","13:150","14:162","15:174","16:176","17:22","18:35","19:41","20:29","21:108","22:21","23:49","24:77","25:53","26:80","27:58","28:45","29:99","30:97","31:79","32:54","33:10","34:44","35:69","36:82","37:112","38:122","39:152","40:76","41:140","42:135","43:104","44:124","45:20","46:19","47:50","48:28","49:118","50:134","51:86","52:92","53:87","54:88","55:121","56:18","57:33","58:52","59:107","60:67","61:56","62:93","63:51","64:114","65:78","66:147","67:146","68:85","69:5","70:43","71:100","72:63","73:31","74:165","75:153","76:24","77:15","78:38","79:36","80:32","81:37","82:66","83:113","84:101","85:129","86:1","87:2","88:9","89:120","90:130","91:11","92:47","93:106","94:171","95:154","96:177","97:183","98:185","99:192","100:189","101:187","102:191","103:190","104:193","105:194","106:34","107:55","108:57","109:91","110:96","111:25","112:71","113:105","114:116","115:90","116:95","117:74","118:70","119:73","120:131","121:167","122:83","123:119","124:128","125:141","126:127","127:111","128:125","129:132","130:149","131:143","132:144","133:163","134:164","135:110","136:158","137:172","138:145","139:117","140:138","141:179","142:142","143:133","144:178","145:180","146:170","147:188","148:159","149:61","150:62","151:98","152:156","153:168","154:160","155:39","156:139","157:115","158:166","159:157","160:0","161:8","162:14","163:59","164:65","165:75","166:173","167:136","168:123","169:126","170:64","171:72","172:102","173:137","174:103","175:169","176:181","177:186","178:109","179:155","180:184","181:175","182:182","183:12","184:30","185:42","186:40","187:48","188:84","189:60","190:81","191:89","192:94","193:151","194:161"];
  Map<Language, List<String>> _getAllCapitals() {
    Map<Language, List<String>> result = HashMap<Language, List<String>>();
    result.putIfAbsent(Language.en, () => _allCapitalsEN());
    result.putIfAbsent(Language.ro, () => _allCapitalsRO());
    return result;
  }
  List<String> _allCapitalsEN() {
    return ["Beijing","New Delhi","Washington","Brasilia","Moscow","Mexico City","Tokyo","Tehran","Berlin","Ankara","Paris","London","Bangkok","Rome","Cairo","Pretoria","Seoul","Madrid","Buenos Aires","Brussels","Kiev","Warsaw","Ottawa","Vienna","Bern","Amsterdam","Jakarta","Athens","Lisbon","Canberra","Bogota","Algiers","Zagreb","Rabat","Hanoi","Stockholm","Abuja","Santiago","Budapest","Bucharest","Riyadh","Sofia","Copenhagen","Helsinki","Dublin","Oslo","Belgrade","Kuala Lumpur","Lima","Tbilisi","Havana","Accra","Astana","Baghdad","Kabul","Jerusalem","Reykjavik","Sarajevo","Yerevan","Ljubljana","Wellington","Tirana","Bratislava","Caracas","Prague","Quito","Dakar","Kathmandu","Mogadishu","Baku","Tunis","Ulan Bator","Islamabad","Manila","Colombo","Nairobi","Phnom Penh","Vilnius","Bamako","Podgorica","Minsk","Yaounde","Tashkent","Naypyidaw","Montevideo","Kingston","Sucre","Kampala","Yamoussoukro","Nicosia","Antananarivo","Port-au-Prince","Luanda","Doha","Pyongyang","Dodoma","Sanaa","Niamey","Addis Ababa","San Jose","Damascus","Amman","Santo Domingo","Abu Dhabi","Tegucigalpa","Dushanbe","Monaco","N'Djamena","Maputo","Tallinn","Singapore","Lusaka","Porto-Novo","Port Moresby","Conakry","Lome","Asuncion","Vientiane","Dhaka","Kigali","Ouagadougou","Tripoli","Beirut","Bishkek","Ashgabat","Lilongwe","Khartoum","Bangui","East Jerusalem","Kinshasa","Muscat","Vaduz","Guatemala City","Juba","Bujumbura","Monrovia","Harare","Kuwait City","Panama City","Freetown","Luxembourg","Asmara","San Marino","Chisinau","Windhoek","Banjul","Nouakchott","Gaborone","Libreville","Brazzaville","Skopje","Maseru","Riga","Bissau","Manama","Malabo","Dili","Port of Spain","Port Louis","Djibouti","Mbabane","Moroni","Suva","Georgetown","San Salvador","Managua","Thimphu","Honiara","Paramaribo","Praia","Valletta","Bandar Seri Begawan","Belmopan","Nassau","Malé","Port Vila","Bridgetown","São Tomé","Apia","Castries","Tarawa","St. George's","Kingstown","Palikir","Nuku'alofa","Victoria","St. John's","Andorra la Vella","Roseau","Majuro","Basseterre","Ngerulmud","Yaren","Funafuti"];
  }
  List<String> _allCapitalsRO() {
    return ["86:Beijing","69:New Delhi","160:Washington","183:Brasilia","33:Moscova","162:Mexico City","87:Tokyo","45:Teheran","0:Berlin","46:Ankara","1:Paris","2:Londra","76:Bangkok","4:Roma","106:Cairo","155:Pretoria","88:Seul","3:Madrid","184:Buenos Aires","5:Bruxelles","32:Kiev","22:Varşovia","161:Ottawa","6:Viena","8:Berna","9:Amsterdam","77:Jakarta","23:Atena","7:Lisabona","91:Canberra","185:Bogota","107:Alger","24:Zagreb","108:Rabat","78:Hanoi","17:Stockholm","111:Abuja","186:Santiago","25:Budapesta","34:Bucureşti","56:Riad","35:Sofia","18:Copenhaga","19:Helsinki","10:Dublin","20:Oslo","36:Belgrad","79:Kuala Lumpur","187:Lima","49:Tbilisi","163:Havana","112:Accra","63:Astana","47:Bagdad","64:Kabul","48:Ierusalim","21:Reykjavik","37:Saraievo","50:Erevan","26:Ljubljana","92:Wellington","38:Tirana","27:Bratislava","188:Caracas","28:Praga","189:Quito","113:Dakar","71:Kathmandu","148:Mogadishu","51:Baku","109:Tunis","90:Ulan Bator","70:Islamabad","80:Manila","72:Colombo","149:Nairobi","84:Phnom Penh","31:Vilnius","114:Bamako","39:Podgorica","40:Minsk","115:Yaounde","65:Taşkent","82:Naypyidaw","190:Montevideo","168:Kingston","191:Sucre","116:Kampala","117:Yamoussoukro","43:Nicosia","124:Antananarivo","169:Port-au-Prince","118:Luanda","58:Doha","89:Phenian","119:Dodoma","59:Sanaa","120:Niamey","150:Addis Ababa","165:San Jose","52:Damasc","53:Amman","170:Santo Domingo","57:Abu Dhabi","174:Tegucigalpa","66:Dușanbe","11:Monaco","125:N'Djamena","126:Maputo","29:Tallinn","81:Singapore","127:Lusaka","128:Porto-Novo","93:Port Moresby","129:Conakry","130:Lome","192:Asuncion","83:Vientiane","73:Dhaka","131:Kigali","123:Ouagadougou","110:Tripoli","54:Beirut","67:Bishkek","68:Așgabat","132:Lilongwe","151:Khartum","121:Bangui","55:Ierusalimul de Est","122:Kinshasa","60:Muscat","13:Vaduz","164:Ciudad de Guatemala","152:Juba","133:Bujumbura","134:Monrovia","135:Harare","61:Kuwait City","171:Ciudad de Panamá","136:Freetown","12:Luxemburg","153:Asmara","15:San Marino","41:Chişinău","156:Windhoek","137:Banjul","138:Nouakchott","157:Gaborone","139:Libreville","140:Brazzaville","42:Skopie","158:Maseru","30:Riga","141:Bissau","62:Manama","142:Malabo","94:Dili","178:Port of Spain","143:Port Louis","154:Djibouti","159:Mbabane","145:Moroni","95:Suva","193:Georgetown","172:San salvador","173:Managua","74:Thimphu","96:Honiara","194:Paramaribo","146:Praia","44:Valletta","85:Bandar Seri Begawan","166:Belmopan","167:Nassau","75:Malé","97:Port Vila","179:Bridgetown","147:São Tomé","98:Apia","175:Castries","99:Tarawa","176:St. George's","180:Kingstown","100:Palikir","101:Nuku'alofa","144:Victoria","181:St. John's","14:Andorra la Vella","177:Roseau","102:Majuro","182:Basseterre","103:Ngerulmud","104:Yaren","105:Funafuti"];
  }
  Map<Language, List<String>> _getAllSynonyms() {
    Map<Language, List<String>> result = HashMap<Language, List<String>>();
    result.putIfAbsent(Language.en, () => _allSynonymsEN());
    result.putIfAbsent(Language.ro, () => _allSynonymsRO());
    return result;
  }
  List<String> _allSynonymsEN() {
    return ["2:USA","103:UAE","129:DR Congo","183:Saint Vincent"];
  }
  List<String> _allSynonymsRO() {
    return ["2:SUA","103:EAU","129:RD Congo"];
  }
  void addEN(Map<Language, Map<CategoryDifficulty, List<Question>>> result,
      GeoQuizGameQuestionConfig questionConfig) {
    var language = Language.en;
    addQuestions(
        result, //
        language, //
        questionConfig.cat0, //
        questionConfig.diff0, //
        ["86:1427647786","69:1352642280","160:327096265","77:267670543","70:212228286","183:209469323","111:195874683","73:161376708","33:145734038","87:127202192","162:126190788","150:109224414","80:106651394","106:102423598","78:95545962","122:84068091","0:83124418","46:82340088","45:81800188","76:68863514","2:67141684","1:64990511","4:60627291","155:57792518","119:56313438","82:53708320","149:51392565","88:51171706","185:49661048","3:46692858","184:44361150","32:44246156","116:42729036","107:42228408","151:41801533","47:38433600","22:37921592","64:37171921","161:37074562","108:36029093","56:33702756","65:32476244","187:31989260","79:31528033","118:30809787","126:29496004","188:28887118","59:28498683","112:28206728","71:28095714","124:26262313","89:25549604","115:25216267","117:25069230","91:24898152","120:22442822","72:21228763","123:19751466","34:19506114","114:19077749","186:18729160","63:18319618","132:18143217","127:17351708","164:17247849","189:17084358","9:17059560","52:16945057","84:16249792","113:15854323","125:15477729","148:15008226","135:14438802","129:12414293","131:12301970","109:11565201","128:11485044","5:11482178","191:11353142","163:11338134","169:11123178","152:10975927","28:10665677","170:10627141","133:10524117","23:10522246","7:10256193","17:9971638","53:9965318","51:9949537","25:9707499","57:9630959","174:9587522","40:9452617","66:9100835","6:8891388","36:8802754","93:8606323","8:8525611","48:8381516","130:7889093","136:7650150","83:7061507","35:7051608","192:6956066","54:6859408","110:6678559","173:6465501","172:6420746","67:6304030","68:5850901","81:5757499","18:5752126","19:5522576","27:5453014","20:5337962","140:5244359","165:4999441","55:4862979","60:4829473","134:4818973","10:4818690","92:4743131","121:4666368","138:4403313","171:4176869","24:4156405","61:4137312","41:4051944","49:4002942","153:3452786","190:3449285","37:3323925","90:3170216","50:2951745","168:2934847","38:2882740","31:2801264","58:2781682","156:2448301","137:2280094","157:2254068","139:2119275","158:2108328","42:2082957","26:2077837","30:1928459","141:1874303","62:1569446","178:1389843","29:1322920","142:1308975","94:1267974","143:1189265","43:1170125","159:1136281","154:958923","95:883483","145:832322","193:779006","74:754388","96:652857","39:627809","12:604245","194:575990","146:543767","75:515696","44:439248","85:428963","167:385637","166:383071","21:336713","97:292680","179:286641","147:211028","98:196129","175:181889","99:115847","100:112640","176:111454","101:110589","180:110211","144:97096","181:96286","14:77006","177:71625","102:58413","182:52441","11:38682","13:37910","15:33785","103:17907","105:11508","104:10670","16:801"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat1, //
        questionConfig.diff0, //
        ["33:17098246","161:9984670","86:9596961","160:9525067","183:8515767","91:7692024","69:3287263","184:2780400","63:2724900","107:2381741","122:2344858","56:2149690","162:1964375","77:1910931","151:1861484","110:1759540","45:1648195","90:1564110","187:1285216","125:1284000","120:1267000","118:1246700","114:1240192","155:1221037","185:1141748","150:1104300","191:1098581","138:1030700","106:1002450","119:945087","111:923768","188:916445","70:907132","156:825615","126:801590","46:783562","186:756102","127:752612","82:676578","64:652230","152:644329","148:637657","121:622984","32:603500","124:587041","157:581730","149:580367","1:543940","59:527968","76:513120","3:505992","68:488100","115:475442","93:462840","17:450295","65:447400","108:446550","47:438317","192:406752","135:390757","87:377975","0:357114","140:342000","19:338424","78:331212","79:330803","20:323802","117:322463","22:312696","60:309500","4:301339","80:300000","189:276841","123:274222","92:270467","139:267668","129:245857","2:242495","116:241550","112:238533","34:238397","83:236800","193:214969","40:207600","67:199951","113:196722","52:185180","84:181035","190:176215","194:163820","109:163610","73:147570","71:147516","66:143100","23:131957","173:130373","89:120540","132:118484","153:117600","128:114763","174:112492","134:111369","35:111002","163:109884","164:108889","21:103000","88:100210","25:93028","7:92090","53:89342","36:88361","51:86600","6:83871","57:83600","28:78865","171:75417","136:71740","10:70273","49:69700","72:65610","31:65300","30:64559","130:56785","24:56594","37:51209","165:51100","27:49037","170:48671","29:45227","18:43094","9:41850","8:41284","74:38394","141:36125","41:33846","5:30528","158:30355","50:29743","96:28896","38:28748","142:28051","133:27834","169:27750","131:26338","42:25713","154:23200","166:22966","172:21041","48:20770","26:20273","95:18272","61:17818","159:17364","94:14919","167:13943","39:13812","97:12189","58:11586","137:11295","168:10991","54:10452","43:9251","55:6020","85:5765","178:5130","146:4033","98:2842","12:2586","143:2040","145:1862","147:964","99:811","62:778","177:751","101:747","81:726","100:702","175:616","14:468","103:459","144:452","181:442","179:430","180:389","176:344","44:316","75:300","182:261","102:181","13:160","15:61","105:26","104:21","11:2.02","16:0.49"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat2, //
        questionConfig.diff0, //
        ["0:6,5,28,18,1,12,9,22,8","160:161,162","49:50,51,33,46","184:191,183,186,192,190","86:64,74,69,63,89,67,83,90,82,71,33,66,78,70","122:118,133,121,140,131,152,119,116,127","6:28,0,25,4,13,27,26,8","1:14,5,0,4,12,11,3,8","33:51,40,86,29,19,49,63,89,30,31,90,20,22,32","36:37,35,24,25,39,42,34","119:133,122,149,132,126,131,116,127","46:50,51,35,49,23,45,47,52","127:118,157,122,132,126,156,119,135","107:110,114,138,108,120,109","25:6,24,34,36,27,26,32","69:73,74,86,82,71,70,72","45:64,50,51,47,70,46,68","114:107,123,117,129,138,120,113","183:184,191,185,193,192,187,194,190,188","120:107,128,123,125,110,114,111","22:40,28,0,31,33,27,32","56:47,53,61,60,58,57,59","151:121,125,106,153,150,110,152","32:40,25,41,22,34,33,27","64:86,45,70,66,68,65","123:128,117,112,114,120,130","115:121,125,140,142,139,111","121:115,125,122,140,152,151","125:115,121,110,120,111,151","150:154,153,149,148,152,151","129:117,141,134,114,113,136","47:45,53,61,56,52,46","4:6,1,15,26,8,16","110:107,125,106,120,151,109","126:159,132,155,119,127,135","155:157,159,158,126,156,135","152:121,122,150,149,151,116","51:50,49,45,33,46","40:30,31,22,33,32","191:184,183,186,192,187","35:23,42,34,36,46","185:183,189,171,187,188","140:118,115,121,122,139","117:123,112,129,134,114","24:37,25,39,36,26","48:106,55,53,54,52","53:47,48,56,52,55","63:86,67,33,68,65","149:150,148,152,119,116","83:84,86,82,76,78","39:38,37,24,36","82:73,86,69,83,76","42:38,35,23,36","187:191,183,186,185,189","34:35,25,41,36,32","113:137,129,141,114,138","27:6,28,25,22,32","3:14,1,7,108","8:6,1,4,13,0","52:47,48,53,54,46","116:122,149,131,152,119","65:64,63,67,66,68","38:23,42,39","118:122,140,156,127","50:51,49,45,46","5:1,0,12,9","128:123,120,111,130","157:156,155,127,135","28:6,0,22,27","106:55,48,110,151","23:38,35,46,42","164:166,172,174,162","67:86,63,66,65","30:40,29,31,33","31:40,30,22,33","138:107,114,113","156:118,157,155,127","111:128,115,125,120","70:64,69,45,86","131:133,122,119,116","26:6,24,4,25","66:64,86,67,65","76:84,83,79,82","68:64,45,63,65","135:157,126,155,127","37:24,39,36","133:122,131,119","84:83,76,78","186:184,191,187","154:153,150","153:154,150,151","19:20,17,33","139:115,140,142","112:123,117,130","193:183,194,188","174:164,172,173","77:94,79,93","89:86,88,33","134:129,117,136","12:5,1,0","132:126,119,127","79:85,77,76","162:166,164,160","108:107,3","9:5,0","20:19,17,33","60:56,57,59","55:106,48,53","192:184,191,183","148:154,150,149","194:183,193","130:128,123,112","188:183,185,193","78:84,86,83","14:1,3","73:69,82","166:164,162","74:86,69","165:173,171","189:185,187","172:164,174","142:115,139","29:30,33","159:126,155","129:113","141:129,113","61:47,56","54:48,52","13:6,8","41:34,32","90:86,33","71:86,69","9:5,0","173:165,174","171:185,165","136:129,134","17:19,20","109:107,110","57:60,56","190:184,183","59:60,56","85:79","161:160","18:0","170:169","94:77","137:113","169:170","10:2","88:89","158:155","11:1","93:77","7:3","58:56","15:4","2:10","16:4"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat3, //
        questionConfig.diff0, //
        ["Nordic countries:18,19,21,20,17", "Balkan Peninsula:42,38,37,35,39,23,36,24,26,34", "Baltic states:29,30,31", "Caribbean:181,179,166,185,165,163,177,170,176,164,169,174,168,162,173,171,182,175,180,178,188", "Maghreb:108,107,109,110,138", "Persian Gulf:56,47,61,58,62,57,60", "Middle East:62,43,106,45,47,48,53,61,54,60,55,58,56,52,46,57,59", "Caucasus:49,50,51", "Indochina:84,83,79,82,76,78", "Central Asia:63,67,66,68,65", "Sub-Saharan Africa:125,114,138,115,111,136,113,121,123,137,142,128,130,117,112,120,134", "Latin America:184,191,183,186,185,165,163,170,189,172,164,169,174,162,173,171,192,187,190,188"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat4, //
        questionConfig.diff0, //
        ["Mughal Empire:50,51,40,29,49,63,67,30,31,41,33,66,68,32,65", "Soviet Union:64,73,69,70", "British Empire:181,91,167,62,73,179,166,74,157,85,115,161,43,177,106,159,95,137,112,176,193,69,47,10,48,53,168,149,99,61,158,110,132,79,75,44,143,82,156,104,92,111,60,70,93,58,182,175,180,98,144,136,81,96,148,155,152,72,151,119,101,178,105,116,57,2,97,59,127,135", "Mongol Empire:64,50,51,40,86,49,69,45,47,63,67,83,41,90,82,89,70,22,34,33,88,52,66,46,68,32,65,78", "Roman Empire:38,107,14,50,6,51,5,37,35,24,43,106,1,49,0,23,25,45,47,48,4,53,61,54,110,13,12,44,11,39,108,9,42,7,34,33,15,56,36,27,26,3,8,52,109,46,32,2,16", "Ottoman Empire:38,107,37,35,24,43,106,153,49,23,25,47,48,53,61,54,110,41,39,42,34,33,56,36,27,151,52,109,46,32", "Portuguese Empire:118,183,146,86,94,129,69,132,126,7,147,190", "Inca Empire:186,184,191,187,189,185", "Mayan Empire:162,164,166,174,172", "Austro-Hungarian Empire:6,25,28,27,34,22,32,36,26,24,37,39,4", "Persian Empire:64,50,51,35,43,106,49,23,69,45,47,48,53,63,61,67,54,110,42,60,70,34,33,56,52,66,46,68,57,32,65"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat5, //
        questionConfig.diff0, //
        ["0::Eiffel Tower, Paris:1,4,8:0", "1::Colosseum, Rome:3,0,8:1", "2::Hollywood Sign, Los Angeles:21,25,17:2", "3::Great Pyramid of Giza, Egypt:1,23,24:3", "4::Statue of Liberty, New York:0,1,25:4", "5::Great Wall of China:6,7,11:5", "6::Angkor Wat, Cambodia:31,20,27:6", "7::Vatican City:26,20,19:7", "8::Leaning Tower of Pisa, Italy:0,1,4:8", "9::Christ the Redeemer, Rio de Janeiro:13,11,7:9", "10::Sydney Opera House, Sydney:32,30,26:10"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat5, //
        questionConfig.diff1, //
        ["11::Acropolis, Athens:5,12,13:11", "12::Taj Mahal, India:11,14,15:12", "13::Blue Mosque, Istanbul:15,11,10:13", "14::Burj Khalifa, Dubai:8,15,23:14", "15::Louvre Museum, Paris:11,8,17:15", "16::Machu Picchu, Peru:31,32,28:16", "17::Berlin Wall:15,11,26:17", "18::Disneyland Resort, California:26,25,21:18"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat5, //
        questionConfig.diff2, //
        ["19::Red Square, Moscow:26,25,33:19", "20::Petra, Jordan:22,1,5:20", "21::The Strip, Las Vegas:17,2,25:21", "22::Grand Palace, Bangkok:26,25,13:22", "23::La Sagrada Familia, Barcelona:7,8,9:23", "24::Terra Cotta Warriors, China:27,29,11:24", "25::Times Square, New York:21,19,10:25", "26::Forbidden City, Beijing:19,12,21:26"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat5, //
        questionConfig.diff3, //
        ["27::Borgund Stave Church, Norway:28,31,34:27", "28::Sheikh Zayed Mosque, Abu Dhabi:27,31,29:28", "29::Neuschwanstein Castle, Germany:13,14,18:29", "30::Oriental Pearl Tower, Shanghai:10,11,7:30", "31::Petronas Twin Towers, Malaysia:28,29,32:31", "32::Victoria Harbour, Hong Kong:26,25,24:32", "33::Library of Celsus, Ephesus:1,20,19:33", "34::Panama Canal, Panama:28,10,16:34"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat8, //
        questionConfig.diff0, //
        ["0::Ha Long Bay, Vietnam:3,2,8:0", "1::Salar de Uyuni, Bolivia:5,2,9:1", "2::The Great Blue Hole, Belize:4,10,8:2", "3::Bali, Indonesia:6,10,2:3", "4::The Aurora Borealis, Norway:5,1,7:4", "5::Mount Fuji, Japan:3,1,11:5", "6::Harbor of Rio De Janeiro, Brazil:2,1,13:6", "7::Paria Canyon, United States:11,6,5:7", "8::Mount Everest, Nepal and Tibet:10,9,13:8", "9::Niagara Falls, Canada:2,6,11:9", "10::Lac Rose, Senegal:17,5,3:10", "11::The Black Forest, Germany:9,15,12:11"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat8, //
        questionConfig.diff1, //
        ["12::Angel Falls, Venezuela:10,9,18:12", "13::Mount Kilimanjaro, Tanzania:8,7,21:13", "14::Danube Delta, Romania:17,15,10:14", "15::Victoria Falls, Zimbabwe and Zambia:21,18,11:15", "16::Eye of the Sahara, Mauritania:13,8,23:16", "17::The Dead Sea, Israel:25,15,24:17", "18::Cliffs of Moher, Ireland:14,16,21:18", "19::Mud volcanoes, Azerbaijan:22,13,27:19", "20::Moraine Lake, Canada:16,22,25:20", "21::Devil's Marbles, Australia:24,13,23:21"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat8, //
        questionConfig.diff2, //
        ["22::Pamukkale, Turkey:16,14,18:22", "23::The River of Five Colors, Colombia:26,19,29:23", "24::Paricutín Volcano, Mexico:30,17,31:24", "25::Moeraki Boulders, New Zealand:31,32,29:25", "26::The Blue Grotto, Italy:28,31,29:26", "27::Marble Caves, Chile:19,25,20:27", "28::Crystal Cave, Bermuda:25,30,35:28"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat8, //
        questionConfig.diff3, //
        ["29::Jeju Island, South Korea:31,25,27:29", "30::Iguazu Falls, Argentina and Brazil:22,23,29:30", "31::Matterhorn, Switzerland:25,28,34:31", "32::Table Mountain, South Africa:26,24,30:32", "33::Bu Tinah, United Arab Emirates:31,29,26:33", "34::Sundarbans, Bangladesh:33,31,28:34", "35::Verdon Gorge, France:32,33,34:35"]);
  }

  void addRO(Map<Language, Map<CategoryDifficulty, List<Question>>> result,
      GeoQuizGameQuestionConfig questionConfig) {
    var language = Language.ro;
    addQuestions(
        result, //
        language, //
        questionConfig.cat3, //
        questionConfig.diff0, //
        ["Țările nordice:18,19,21,20,17", "Peninsula Balcanică:42,38,37,35,39,23,36,24,26,34", "Statele baltice:29,30,31", "Caraibe:181,179,166,185,165,163,177,170,176,164,169,174,168,162,173,171,182,175,180,178,188", "Magreb:108,107,109,110,138", "Golful Persic:56,47,61,58,62,57,60", "Orientul Mijlociu:62,43,106,45,47,48,53,61,54,60,55,58,56,52,46,57,59", "Caucaz:49,50,51", "Indochina:84,83,79,82,76,78", "Asia Centrală:63,67,66,68,65", "Africa Subsahariană:125,114,138,115,111,136,113,121,123,137,142,128,130,117,112,120,134", "America Latină:184,191,183,186,185,165,163,170,189,172,164,169,174,162,173,171,192,187,190,188"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat4, //
        questionConfig.diff0, //
        ["Imperiul Mogul:50,51,40,29,49,63,67,30,31,41,33,66,68,32,65", "Uniunea Sovietică:64,73,69,70", "Imperiul Britanic:181,91,167,62,73,179,166,74,157,85,115,161,43,177,106,159,95,137,112,176,193,69,47,10,48,53,168,149,99,61,158,110,132,79,75,44,143,82,156,104,92,111,60,70,93,58,182,175,180,98,144,136,81,96,148,155,152,72,151,119,101,178,105,116,57,2,97,59,127,135", "Imperiul Mongol:64,50,51,40,86,49,69,45,47,63,67,83,41,90,82,89,70,22,34,33,88,52,66,46,68,32,65,78", "Imperiul Roman:38,107,14,50,6,51,5,37,35,24,43,106,1,49,0,23,25,45,47,48,4,53,61,54,110,13,12,44,11,39,108,9,42,7,34,33,15,56,36,27,26,3,8,52,109,46,32,2,16", "Imperiul Otoman:38,107,37,35,24,43,106,153,49,23,25,47,48,53,61,54,110,41,39,42,34,33,56,36,27,151,52,109,46,32", "Imperiul Portughez:118,183,146,86,94,129,69,132,126,7,147,190", "Imperiul Inca:186,184,191,187,189,185", "Imperiul Maya:162,164,166,174,172", "Imperiul Austro-Ungar:6,25,28,27,34,22,32,36,26,24,37,39,4", "Imperiul Persan:64,50,51,35,43,106,49,23,69,45,47,48,53,63,61,67,54,110,42,60,70,34,33,56,52,66,46,68,57,32,65"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat5, //
        questionConfig.diff0, //
        ["0::Turnul Eiffel, Paris:1,4,8:0", "1::Colosseum, Roma:3,0,8:1", "2::Semnul Hollywood, Los Angeles:21,25,17:2", "3::Marea Piramidă din Giza, Egipt:1,23,24:3", "4::Statuia Libertăţii, New York:0,1,25:4", "5::Marele Zid Chinezesc:6,7,11:5", "6::Angkor Wat, Cambodgia:31,20,27:6", "7::Vatican:26,20,19:7", "8::Turnul înclinat din Pisa, Italia:0,1,4:8", "9::Hristos Răscumpărătorul, Rio de Janeiro:13,11,7:9", "10::Sydney Opera House, Sydney:32,30,26:10"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat5, //
        questionConfig.diff1, //
        ["11::Acropola din Atena, Atena:5,12,13:11", "12::Taj Mahal, India:11,14,15:12", "13::Moscheea Albastră, Istanbul:15,11,10:13", "14::Burj Khalifa, Dubai:8,15,23:14", "15::Muzeul Luvru, Paris:11,8,17:15", "16::Machu Picchu, Peru:31,32,28:16", "17::Zidul Berlinului:15,11,26:17", "18::Disneyland Resort, California:26,25,21:18"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat5, //
        questionConfig.diff2, //
        ["19::Piaţa Roşie, Moscova:26,25,33:19", "20::Petra, Iordania:22,1,5:20", "21::Fâşia, Las Vegas:17,2,25:21", "22::Palatul Grand, Bangkok:26,25,13:22", "23::La Sagrada Familia, Barcelona:7,8,9:23", "24::Armata de Teracotă, China:27,29,11:24", "25::Times Square, New York:21,19,10:25", "26::Oraşul interzis, Beijing:19,12,21:26"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat5, //
        questionConfig.diff3, //
        ["27::Biserica Borgund Stave, Norvegia:28,31,34:27", "28::Moscheea Șeicului Zayed , Abu Dhabi:27,31,29:28", "29::Castelul Neuschwanstein, Germania:13,14,18:29", "30::Turnul Pearl Oriental, Shanghai:10,11,7:30", "31::Turnurile Petronas, Malaezia:28,29,32:31", "32::Portul Victoria, Hong Kong:26,25,24:32", "33::Biblioteca lui Celsus, Efes:1,20,19:33", "34::Canalul Panama, Panama:28,10,16:34"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat8, //
        questionConfig.diff0, //
        ["0::Ha Long Bay, Vietnam:3,2,8:0", "1::Salar de Uyuni, Bolivia:5,2,9:1", "2::Marea Gaură Albastră, Belize:4,10,8:2", "3::Bali, Indonezia:6,10,2:3", "4::Auroră polară, Norvegia:5,1,7:4", "5::Muntele Fuji, Japonia:3,1,11:5", "6::Portul din Rio De Janeiro, Brazilia:2,1,13:6", "7::Canionul Paria, Statele Unite:11,6,5:7", "8::Muntele Everest, Nepal şi Tibet:10,9,13:8", "9::Cascada Niagara, Canada:2,6,11:9", "10::Lac Rose, Senegal:17,5,3:10", "11::Pădurea Neagră, Germania:9,15,12:11"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat8, //
        questionConfig.diff1, //
        ["12::Cascada Angel, Venezuela:10,9,18:12", "13::Muntele Kilimanjaro, Tanzania:8,7,21:13", "14::Delta Dunării, România:17,15,10:14", "15::Cascadele din Victoria, Zimbabwe şi Zambia:21,18,11:15", "16::Ochiul Saharei, Mauritania:13,8,23:16", "17::Marea Moartă, Israel:25,15,24:17", "18::Stâncile din Moher, Irlanda:14,16,21:18", "19::Vulcanii noroi, Azerbaijan:22,13,27:19", "20::Lacul Moraine, Canada:16,22,25:20", "21::Pietrele Diavolului, Australia:24,13,23:21"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat8, //
        questionConfig.diff2, //
        ["22::Pamukkale, Turcia:16,14,18:22", "23::Râul cu Cinci Culori, Columbia:26,19,29:23", "24::Vulcan Paricutín, Mexic:30,17,31:24", "25::Bolovanii Moeraki, Noua Zeelandă:31,32,29:25", "26::Grota Albastră, Italia:28,31,29:26", "27::Peştera de marmură, Chile:19,25,20:27", "28::Peştera de cristal, Bermuda:25,30,35:28"]);
    addQuestions(
        result, //
        language, //
        questionConfig.cat8, //
        questionConfig.diff3, //
        ["29::Insula Jeju, Coreea de Sud:31,25,27:29", "30::Cascadele de pe Iguazú, Argentina şi Brazilia:22,23,29:30", "31::Matterhorn, Elveţia:25,28,34:31", "32::Muntele Masa, Africa de Sud:26,24,30:32", "33::Bu Tinah, Emiratele Arabe Unite:31,29,26:33", "34::Sundarbans, Bangladesh:33,31,28:34", "35::Cheile Verdon, Franţa:32,33,34:35"]);
  }

}

class CountryRanges {

  int start;
  int end;
  int maxStart;
  int maxEnd;

  CountryRanges(this.start, this.end, this.maxStart, this.maxEnd);
}
