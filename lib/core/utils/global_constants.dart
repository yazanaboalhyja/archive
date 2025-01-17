import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String uri = "http://127.0.0.1:3000";
const defaultAppColor = Color(0xFF000000);
var amountFormatter = NumberFormat.decimalPattern('en_US');
const String notEmptyError = "This field cannot be empty.";
const String fieldNotValidError = "This field is not valid.";
Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return hslDark.toColor();
}

var platformDispatcher = PlatformDispatcher.instance;
var screenHeight = platformDispatcher.views.first.physicalSize.height /
    platformDispatcher.views.first.devicePixelRatio;
var screenWidth = platformDispatcher.views.first.physicalSize.width /
    platformDispatcher.views.first.devicePixelRatio;
var isTablet = (platformDispatcher.views.first.physicalSize.width /
        platformDispatcher.views.first.devicePixelRatio) >
    600;

// /*This is the default screen width that is used to obtain the values below
// =>428

// This is the default screen height that is used to obtain the values below
// =>926

// These are dynamic width values that change if the screen width changes
// This is very important for adapting to screen sizes*/

// //This is mostly used for width value and font sizes
// //428
// final value3 = screenWidth / 142.66;
// final value5 = screenWidth / 85.6;
// final value10 = screenWidth / 42.8;
// final value11 = screenWidth / 38.90;
// final value12 = screenWidth / 35.66;
// final value14 = screenWidth / 30.57;
// final value15 = screenWidth / 28.5;
// final value16 = screenWidth / 26.75;
// final value18 = screenWidth / 23.77;
// final value20 = screenWidth / 21.4;
// final value24 = screenWidth / 17.83;
// final value25 = screenWidth / 17.12;
// final value30 = screenWidth / 14.26;
// final value35 = screenWidth / 12.22;
// final value40 = screenWidth / 10.7;
// final value45 = screenWidth / 9.51;
// final value50 = screenWidth / 8.56;
// final value55 = screenWidth / 7.78;
// final value48 = screenWidth / 8.91;
// final value60 = screenWidth / 7.13;
// final value65 = screenWidth / 6.58;
// final value70 = screenWidth / 6.11;
// final value80 = screenWidth / 5.35;
// final value90 = screenWidth / 4.755;
// final value100 = screenWidth / 4.28;
// final value110 = screenWidth / 3.89;
// final value130 = screenWidth / 3.29;
// final value145 = screenWidth / 2.95;
// final value165 = screenWidth / 2.59;
// final value200 = screenWidth / 2.14;
// final value220 = screenWidth / 1.94;

// //This is mostly used for height values
// //926
final heightValue1 = screenHeight / 602;
final heightValue2 = screenHeight / 301;
final heightValue3 = screenHeight / 200.667;
final heightValue4 = screenHeight / 150.5;
final heightValue5 = screenHeight / 120.4;
final heightValue6 = screenHeight / 100.333;
final heightValue7 = screenHeight / 86;
final heightValue8 = screenHeight / 75.25;
final heightValue9 = screenHeight / 66.8889;
final heightValue10 = screenHeight / 60.2;
final heightValue11 = screenHeight / 54.7273;
final heightValue12 = screenHeight / 50.1667;
final heightValue13 = screenHeight / 46.3077;
final heightValue14 = screenHeight / 43;
final heightValue15 = screenHeight / 40.1333;
final heightValue16 = screenHeight / 37.625;
final heightValue17 = screenHeight / 35.4118;
final heightValue18 = screenHeight / 33.4444;
final heightValue19 = screenHeight / 31.6842;
final heightValue20 = screenHeight / 30.1;
final heightValue21 = screenHeight / 28.6667;
final heightValue22 = screenHeight / 27.3636;
final heightValue23 = screenHeight / 26.1739;
final heightValue24 = screenHeight / 25.0833;
final heightValue25 = screenHeight / 24.08;
final heightValue26 = screenHeight / 23.1538;
final heightValue27 = screenHeight / 22.2963;
final heightValue28 = screenHeight / 21.5;
final heightValue29 = screenHeight / 20.7586;
final heightValue30 = screenHeight / 20.0667;
final heightValue31 = screenHeight / 19.4194;
final heightValue32 = screenHeight / 18.8125;
final heightValue33 = screenHeight / 18.2424;
final heightValue34 = screenHeight / 17.7059;
final heightValue35 = screenHeight / 17.2;
final heightValue36 = screenHeight / 16.7222;
final heightValue37 = screenHeight / 16.2703;
final heightValue38 = screenHeight / 15.8421;
final heightValue39 = screenHeight / 15.4359;
final heightValue40 = screenHeight / 15.05;
final heightValue41 = screenHeight / 14.6829;
final heightValue42 = screenHeight / 14.3333;
final heightValue43 = screenHeight / 14;
final heightValue44 = screenHeight / 13.6818;
final heightValue45 = screenHeight / 13.3778;
final heightValue46 = screenHeight / 13.087;
final heightValue47 = screenHeight / 12.8085;
final heightValue48 = screenHeight / 12.5417;
final heightValue49 = screenHeight / 12.2857;
final heightValue50 = screenHeight / 12.04;
final heightValue51 = screenHeight / 11.8039;
final heightValue52 = screenHeight / 11.5769;
final heightValue53 = screenHeight / 11.3585;
final heightValue54 = screenHeight / 11.1481;
final heightValue55 = screenHeight / 10.9455;
final heightValue56 = screenHeight / 10.75;
final heightValue57 = screenHeight / 10.5614;
final heightValue58 = screenHeight / 10.3793;
final heightValue59 = screenHeight / 10.2034;
final heightValue60 = screenHeight / 10.0333;
final heightValue61 = screenHeight / 9.86885;
final heightValue62 = screenHeight / 9.70968;
final heightValue63 = screenHeight / 9.55556;
final heightValue64 = screenHeight / 9.40625;
final heightValue65 = screenHeight / 9.26154;
final heightValue66 = screenHeight / 9.12121;
final heightValue67 = screenHeight / 8.98507;
final heightValue68 = screenHeight / 8.85294;
final heightValue69 = screenHeight / 8.72464;
final heightValue70 = screenHeight / 8.6;
final heightValue71 = screenHeight / 8.47887;
final heightValue72 = screenHeight / 8.36111;
final heightValue73 = screenHeight / 8.24658;
final heightValue74 = screenHeight / 8.13513;
final heightValue75 = screenHeight / 8.02667;
final heightValue76 = screenHeight / 7.92105;
final heightValue77 = screenHeight / 7.81818;
final heightValue78 = screenHeight / 7.71795;
final heightValue79 = screenHeight / 7.62025;
final heightValue80 = screenHeight / 7.525;
final heightValue81 = screenHeight / 7.4321;
final heightValue82 = screenHeight / 7.34146;
final heightValue83 = screenHeight / 7.25301;
final heightValue84 = screenHeight / 7.16667;
final heightValue85 = screenHeight / 7.08235;
final heightValue86 = screenHeight / 7;
final heightValue87 = screenHeight / 6.91954;
final heightValue88 = screenHeight / 6.84091;
final heightValue89 = screenHeight / 6.76404;
final heightValue90 = screenHeight / 6.68889;
final heightValue91 = screenHeight / 6.61538;
final heightValue92 = screenHeight / 6.54348;
final heightValue93 = screenHeight / 6.47312;
final heightValue94 = screenHeight / 6.40426;
final heightValue95 = screenHeight / 6.33684;
final heightValue96 = screenHeight / 6.27083;
final heightValue97 = screenHeight / 6.20619;
final heightValue98 = screenHeight / 6.14286;
final heightValue99 = screenHeight / 6.08081;
final heightValue100 = screenHeight / 6.02;
final heightValue101 = screenHeight / 5.9604;
final heightValue102 = screenHeight / 5.90196;
final heightValue103 = screenHeight / 5.84466;
final heightValue104 = screenHeight / 5.78846;
final heightValue105 = screenHeight / 5.73333;
final heightValue106 = screenHeight / 5.67925;
final heightValue107 = screenHeight / 5.62617;
final heightValue108 = screenHeight / 5.57407;
final heightValue109 = screenHeight / 5.52294;
final heightValue110 = screenHeight / 5.47273;
final heightValue111 = screenHeight / 5.42342;
final heightValue112 = screenHeight / 5.375;
final heightValue113 = screenHeight / 5.32743;
final heightValue114 = screenHeight / 5.2807;
final heightValue115 = screenHeight / 5.23478;
final heightValue116 = screenHeight / 5.18966;
final heightValue117 = screenHeight / 5.1453;
final heightValue118 = screenHeight / 5.1017;
final heightValue119 = screenHeight / 5.05882;
final heightValue120 = screenHeight / 5.01667;
final heightValue121 = screenHeight / 4.97521;
final heightValue122 = screenHeight / 4.93443;
final heightValue123 = screenHeight / 4.89431;
final heightValue124 = screenHeight / 4.85484;
final heightValue125 = screenHeight / 4.816;
final heightValue126 = screenHeight / 4.77778;
final heightValue127 = screenHeight / 4.74016;
final heightValue128 = screenHeight / 4.70312;
final heightValue129 = screenHeight / 4.66667;
final heightValue130 = screenHeight / 4.63077;
final heightValue131 = screenHeight / 4.59542;
final heightValue132 = screenHeight / 4.56061;
final heightValue133 = screenHeight / 4.52632;
final heightValue134 = screenHeight / 4.49254;
final heightValue135 = screenHeight / 4.45926;
final heightValue136 = screenHeight / 4.42647;
final heightValue137 = screenHeight / 4.39416;
final heightValue138 = screenHeight / 4.36232;
final heightValue139 = screenHeight / 4.33094;
final heightValue140 = screenHeight / 4.3;
final heightValue141 = screenHeight / 4.2695;
final heightValue142 = screenHeight / 4.23944;
final heightValue143 = screenHeight / 4.20979;
final heightValue144 = screenHeight / 4.18056;
final heightValue145 = screenHeight / 4.15172;
final heightValue146 = screenHeight / 4.12329;
final heightValue147 = screenHeight / 4.09524;
final heightValue148 = screenHeight / 4.06757;
final heightValue149 = screenHeight / 4.04027;
final heightValue150 = screenHeight / 4.01333;
final heightValue151 = screenHeight / 3.98675;
final heightValue152 = screenHeight / 3.96053;
final heightValue153 = screenHeight / 3.93464;
final heightValue154 = screenHeight / 3.90909;
final heightValue155 = screenHeight / 3.88387;
final heightValue156 = screenHeight / 3.85897;
final heightValue157 = screenHeight / 3.83439;
final heightValue158 = screenHeight / 3.81013;
final heightValue159 = screenHeight / 3.78616;
final heightValue160 = screenHeight / 3.7625;
final heightValue161 = screenHeight / 3.73913;
final heightValue162 = screenHeight / 3.71605;
final heightValue163 = screenHeight / 3.69325;
final heightValue164 = screenHeight / 3.67073;
final heightValue165 = screenHeight / 3.64848;
final heightValue166 = screenHeight / 3.62651;
final heightValue167 = screenHeight / 3.60479;
final heightValue168 = screenHeight / 3.58333;
final heightValue169 = screenHeight / 3.56213;
final heightValue170 = screenHeight / 3.54118;
final heightValue171 = screenHeight / 3.52047;
final heightValue172 = screenHeight / 3.5;
final heightValue173 = screenHeight / 3.47977;
final heightValue174 = screenHeight / 3.45977;
final heightValue175 = screenHeight / 3.44;
final heightValue176 = screenHeight / 3.42045;
final heightValue177 = screenHeight / 3.40113;
final heightValue178 = screenHeight / 3.38202;
final heightValue179 = screenHeight / 3.36313;
final heightValue180 = screenHeight / 3.34444;
final heightValue181 = screenHeight / 3.32597;
final heightValue182 = screenHeight / 3.30769;
final heightValue183 = screenHeight / 3.28962;
final heightValue184 = screenHeight / 3.27174;
final heightValue185 = screenHeight / 3.25405;
final heightValue186 = screenHeight / 3.23656;
final heightValue187 = screenHeight / 3.21925;
final heightValue188 = screenHeight / 3.20213;
final heightValue189 = screenHeight / 3.18519;
final heightValue190 = screenHeight / 3.16842;
final heightValue191 = screenHeight / 3.15183;
final heightValue192 = screenHeight / 3.13542;
final heightValue193 = screenHeight / 3.11917;
final heightValue194 = screenHeight / 3.10309;
final heightValue195 = screenHeight / 3.08718;
final heightValue196 = screenHeight / 3.07143;
final heightValue197 = screenHeight / 3.05584;
final heightValue198 = screenHeight / 3.0404;
final heightValue199 = screenHeight / 3.02513;
final heightValue200 = screenHeight / 3.01;
final heightValue201 = screenHeight / 2.99502;
final heightValue202 = screenHeight / 2.9802;
final heightValue203 = screenHeight / 2.96552;
final heightValue204 = screenHeight / 2.95098;
final heightValue205 = screenHeight / 2.93659;
final heightValue206 = screenHeight / 2.92233;
final heightValue207 = screenHeight / 2.90821;
final heightValue208 = screenHeight / 2.89423;
final heightValue209 = screenHeight / 2.88038;
final heightValue210 = screenHeight / 2.86667;
final heightValue211 = screenHeight / 2.85308;
final heightValue212 = screenHeight / 2.83962;
final heightValue213 = screenHeight / 2.82629;
final heightValue214 = screenHeight / 2.81308;
final heightValue215 = screenHeight / 2.8;
final heightValue216 = screenHeight / 2.78704;
final heightValue217 = screenHeight / 2.77419;
final heightValue218 = screenHeight / 2.76147;
final heightValue219 = screenHeight / 2.74886;
final heightValue220 = screenHeight / 2.73636;
final heightValue221 = screenHeight / 2.72398;
final heightValue222 = screenHeight / 2.71171;
final heightValue223 = screenHeight / 2.69955;
final heightValue224 = screenHeight / 2.6875;
final heightValue225 = screenHeight / 2.67556;
final heightValue226 = screenHeight / 2.66372;
final heightValue227 = screenHeight / 2.65198;
final heightValue228 = screenHeight / 2.64035;
final heightValue229 = screenHeight / 2.62882;
final heightValue230 = screenHeight / 2.61739;
final heightValue231 = screenHeight / 2.60606;
final heightValue232 = screenHeight / 2.59483;
final heightValue233 = screenHeight / 2.58369;
final heightValue234 = screenHeight / 2.57265;
final heightValue235 = screenHeight / 2.5617;
final heightValue236 = screenHeight / 2.55085;
final heightValue237 = screenHeight / 2.54008;
final heightValue238 = screenHeight / 2.52941;
final heightValue239 = screenHeight / 2.51883;
final heightValue240 = screenHeight / 2.50833;
final heightValue241 = screenHeight / 2.49793;
final heightValue242 = screenHeight / 2.4876;
final heightValue243 = screenHeight / 2.47737;
final heightValue244 = screenHeight / 2.46721;
final heightValue245 = screenHeight / 2.45714;
final heightValue246 = screenHeight / 2.44715;
final heightValue247 = screenHeight / 2.43725;
final heightValue248 = screenHeight / 2.42742;
final heightValue249 = screenHeight / 2.41767;
final heightValue250 = screenHeight / 2.408;
final heightValue251 = screenHeight / 2.39841;
final heightValue252 = screenHeight / 2.38889;
final heightValue253 = screenHeight / 2.37945;
final heightValue254 = screenHeight / 2.37008;
final heightValue255 = screenHeight / 2.36078;
final heightValue256 = screenHeight / 2.35156;
final heightValue257 = screenHeight / 2.34241;
final heightValue258 = screenHeight / 2.33333;
final heightValue259 = screenHeight / 2.32432;
final heightValue260 = screenHeight / 2.31538;
final heightValue261 = screenHeight / 2.30651;
final heightValue262 = screenHeight / 2.29771;
final heightValue263 = screenHeight / 2.28897;
final heightValue264 = screenHeight / 2.2803;
final heightValue265 = screenHeight / 2.2717;
final heightValue266 = screenHeight / 2.26316;
final heightValue267 = screenHeight / 2.25468;
final heightValue268 = screenHeight / 2.24627;
final heightValue269 = screenHeight / 2.23792;
final heightValue270 = screenHeight / 2.22963;
final heightValue271 = screenHeight / 2.2214;
final heightValue272 = screenHeight / 2.21324;
final heightValue273 = screenHeight / 2.20513;
final heightValue274 = screenHeight / 2.19708;
final heightValue275 = screenHeight / 2.18909;
final heightValue276 = screenHeight / 2.18116;
final heightValue277 = screenHeight / 2.17329;
final heightValue278 = screenHeight / 2.16547;
final heightValue279 = screenHeight / 2.15771;
final heightValue280 = screenHeight / 2.15;
final heightValue281 = screenHeight / 2.14235;
final heightValue282 = screenHeight / 2.13475;
final heightValue283 = screenHeight / 2.12721;
final heightValue284 = screenHeight / 2.11972;
final heightValue285 = screenHeight / 2.11228;
final heightValue286 = screenHeight / 2.1049;
final heightValue287 = screenHeight / 2.09756;
final heightValue288 = screenHeight / 2.09028;
final heightValue289 = screenHeight / 2.08305;
final heightValue290 = screenHeight / 2.07586;
final heightValue291 = screenHeight / 2.06873;
final heightValue292 = screenHeight / 2.06164;
final heightValue293 = screenHeight / 2.05461;
final heightValue294 = screenHeight / 2.04762;
final heightValue295 = screenHeight / 2.04068;
final heightValue296 = screenHeight / 2.03378;
final heightValue297 = screenHeight / 2.02694;
final heightValue298 = screenHeight / 2.02013;
final heightValue299 = screenHeight / 2.01338;
final heightValue300 = screenHeight / 2.00667;
final heightValue301 = screenHeight / 2;
final heightValue302 = screenHeight / 1.99338;
final heightValue303 = screenHeight / 1.9868;
final heightValue304 = screenHeight / 1.98026;
final heightValue305 = screenHeight / 1.97377;
final heightValue306 = screenHeight / 1.96732;
final heightValue307 = screenHeight / 1.96091;
final heightValue308 = screenHeight / 1.95455;
final heightValue309 = screenHeight / 1.94822;
final heightValue310 = screenHeight / 1.94194;
final heightValue311 = screenHeight / 1.93569;
final heightValue312 = screenHeight / 1.92949;
final heightValue313 = screenHeight / 1.92332;
final heightValue314 = screenHeight / 1.9172;
final heightValue315 = screenHeight / 1.91111;
final heightValue316 = screenHeight / 1.90506;
final heightValue317 = screenHeight / 1.89905;
final heightValue318 = screenHeight / 1.89308;
final heightValue319 = screenHeight / 1.88715;
final heightValue320 = screenHeight / 1.88125;
final heightValue321 = screenHeight / 1.87539;
final heightValue322 = screenHeight / 1.86957;
final heightValue323 = screenHeight / 1.86378;
final heightValue324 = screenHeight / 1.85802;
final heightValue325 = screenHeight / 1.85231;
final heightValue326 = screenHeight / 1.84663;
final heightValue327 = screenHeight / 1.84098;
final heightValue328 = screenHeight / 1.83537;
final heightValue329 = screenHeight / 1.82979;
final heightValue330 = screenHeight / 1.82424;
final heightValue331 = screenHeight / 1.81873;
final heightValue332 = screenHeight / 1.81325;
final heightValue333 = screenHeight / 1.80781;
final heightValue334 = screenHeight / 1.8024;
final heightValue335 = screenHeight / 1.79701;
final heightValue336 = screenHeight / 1.79167;
final heightValue337 = screenHeight / 1.78635;
final heightValue338 = screenHeight / 1.78107;
final heightValue339 = screenHeight / 1.77581;
final heightValue340 = screenHeight / 1.77059;
final heightValue341 = screenHeight / 1.7654;
final heightValue342 = screenHeight / 1.76023;
final heightValue343 = screenHeight / 1.7551;
final heightValue344 = screenHeight / 1.75;
final heightValue345 = screenHeight / 1.74493;
final heightValue346 = screenHeight / 1.73988;
final heightValue347 = screenHeight / 1.73487;
final heightValue348 = screenHeight / 1.72989;
final heightValue349 = screenHeight / 1.72493;
final heightValue350 = screenHeight / 1.72;
final heightValue351 = screenHeight / 1.7151;
final heightValue352 = screenHeight / 1.71023;
final heightValue353 = screenHeight / 1.70538;
final heightValue354 = screenHeight / 1.70056;
final heightValue355 = screenHeight / 1.69577;
final heightValue356 = screenHeight / 1.69101;
final heightValue357 = screenHeight / 1.68627;
final heightValue358 = screenHeight / 1.68156;
final heightValue359 = screenHeight / 1.67688;
final heightValue360 = screenHeight / 1.67222;
final heightValue361 = screenHeight / 1.66759;
final heightValue362 = screenHeight / 1.66298;
final heightValue363 = screenHeight / 1.6584;
final heightValue364 = screenHeight / 1.65385;
final heightValue365 = screenHeight / 1.64932;
final heightValue366 = screenHeight / 1.64481;
final heightValue367 = screenHeight / 1.64033;
final heightValue368 = screenHeight / 1.63587;
final heightValue369 = screenHeight / 1.63144;
final heightValue370 = screenHeight / 1.62703;
final heightValue371 = screenHeight / 1.62264;
final heightValue372 = screenHeight / 1.61828;
final heightValue373 = screenHeight / 1.61394;
final heightValue374 = screenHeight / 1.60963;
final heightValue375 = screenHeight / 1.60533;
final heightValue376 = screenHeight / 1.60106;
final heightValue377 = screenHeight / 1.59682;
final heightValue378 = screenHeight / 1.59259;
final heightValue379 = screenHeight / 1.58839;
final heightValue380 = screenHeight / 1.58421;
final heightValue381 = screenHeight / 1.58005;
final heightValue382 = screenHeight / 1.57592;
final heightValue383 = screenHeight / 1.5718;
final heightValue384 = screenHeight / 1.56771;
final heightValue385 = screenHeight / 1.56364;
final heightValue386 = screenHeight / 1.55959;
final heightValue387 = screenHeight / 1.55556;
final heightValue388 = screenHeight / 1.55155;
final heightValue389 = screenHeight / 1.54756;
final heightValue390 = screenHeight / 1.54359;
final heightValue391 = screenHeight / 1.53964;
final heightValue392 = screenHeight / 1.53571;
final heightValue393 = screenHeight / 1.53181;
final heightValue394 = screenHeight / 1.52792;
final heightValue395 = screenHeight / 1.52405;
final heightValue396 = screenHeight / 1.5202;
final heightValue397 = screenHeight / 1.51637;
final heightValue398 = screenHeight / 1.51256;
final heightValue399 = screenHeight / 1.50877;
final heightValue400 = screenHeight / 1.505;
final heightValue401 = screenHeight / 1.50125;
final heightValue402 = screenHeight / 1.49751;
final heightValue403 = screenHeight / 1.4938;
final heightValue404 = screenHeight / 1.4901;
final heightValue405 = screenHeight / 1.48642;
final heightValue406 = screenHeight / 1.48276;
final heightValue407 = screenHeight / 1.47912;
final heightValue408 = screenHeight / 1.47549;
final heightValue409 = screenHeight / 1.47188;
final heightValue410 = screenHeight / 1.46829;
final heightValue411 = screenHeight / 1.46472;
final heightValue412 = screenHeight / 1.46117;
final heightValue413 = screenHeight / 1.45763;
final heightValue414 = screenHeight / 1.45411;
final heightValue415 = screenHeight / 1.4506;
final heightValue416 = screenHeight / 1.44712;
final heightValue417 = screenHeight / 1.44365;
final heightValue418 = screenHeight / 1.44019;
final heightValue419 = screenHeight / 1.43675;
final heightValue420 = screenHeight / 1.43333;
final heightValue421 = screenHeight / 1.42993;
final heightValue422 = screenHeight / 1.42654;
final heightValue423 = screenHeight / 1.42317;
final heightValue424 = screenHeight / 1.41981;
final heightValue425 = screenHeight / 1.41647;
final heightValue426 = screenHeight / 1.41315;
final heightValue427 = screenHeight / 1.40984;
final heightValue428 = screenHeight / 1.40654;
final heightValue429 = screenHeight / 1.40326;
final heightValue430 = screenHeight / 1.4;
final heightValue431 = screenHeight / 1.39675;
final heightValue432 = screenHeight / 1.39352;
final heightValue433 = screenHeight / 1.3903;
final heightValue434 = screenHeight / 1.3871;
final heightValue435 = screenHeight / 1.38391;
final heightValue436 = screenHeight / 1.38073;
final heightValue437 = screenHeight / 1.37757;
final heightValue438 = screenHeight / 1.37443;
final heightValue439 = screenHeight / 1.3713;
final heightValue440 = screenHeight / 1.36818;
final heightValue441 = screenHeight / 1.36508;
final heightValue442 = screenHeight / 1.36199;
final heightValue443 = screenHeight / 1.35892;
final heightValue444 = screenHeight / 1.35586;
final heightValue445 = screenHeight / 1.35281;
final heightValue446 = screenHeight / 1.34978;
final heightValue447 = screenHeight / 1.34676;
final heightValue448 = screenHeight / 1.34375;
final heightValue449 = screenHeight / 1.34076;
final heightValue450 = screenHeight / 1.33778;
final heightValue451 = screenHeight / 1.33481;
final heightValue452 = screenHeight / 1.33186;
final heightValue453 = screenHeight / 1.32892;
final heightValue454 = screenHeight / 1.32599;
final heightValue455 = screenHeight / 1.32308;
final heightValue456 = screenHeight / 1.32018;
final heightValue457 = screenHeight / 1.31729;
final heightValue458 = screenHeight / 1.31441;
final heightValue459 = screenHeight / 1.31155;
final heightValue460 = screenHeight / 1.3087;
final heightValue461 = screenHeight / 1.30586;
final heightValue462 = screenHeight / 1.30303;
final heightValue463 = screenHeight / 1.30022;
final heightValue464 = screenHeight / 1.29741;
final heightValue465 = screenHeight / 1.29462;
final heightValue466 = screenHeight / 1.29185;
final heightValue467 = screenHeight / 1.28908;
final heightValue468 = screenHeight / 1.28632;
final heightValue469 = screenHeight / 1.28358;
final heightValue470 = screenHeight / 1.28085;
final heightValue471 = screenHeight / 1.27813;
final heightValue472 = screenHeight / 1.27542;
final heightValue473 = screenHeight / 1.27273;
final heightValue474 = screenHeight / 1.27004;
final heightValue475 = screenHeight / 1.26737;
final heightValue476 = screenHeight / 1.26471;
final heightValue477 = screenHeight / 1.26205;
final heightValue478 = screenHeight / 1.25941;
final heightValue479 = screenHeight / 1.25678;
final heightValue480 = screenHeight / 1.25417;
final heightValue481 = screenHeight / 1.25156;
final heightValue482 = screenHeight / 1.24896;
final heightValue483 = screenHeight / 1.24638;
final heightValue484 = screenHeight / 1.2438;
final heightValue485 = screenHeight / 1.24124;
final heightValue486 = screenHeight / 1.23868;
final heightValue487 = screenHeight / 1.23614;
final heightValue488 = screenHeight / 1.23361;
final heightValue489 = screenHeight / 1.23108;
final heightValue490 = screenHeight / 1.22857;
final heightValue491 = screenHeight / 1.22607;
final heightValue492 = screenHeight / 1.22358;
final heightValue493 = screenHeight / 1.2211;
final heightValue494 = screenHeight / 1.21862;
final heightValue495 = screenHeight / 1.21616;
final heightValue496 = screenHeight / 1.21371;
final heightValue497 = screenHeight / 1.21127;
final heightValue498 = screenHeight / 1.20884;
final heightValue499 = screenHeight / 1.20641;
final heightValue500 = screenHeight / 1.204;
final heightValue501 = screenHeight / 1.2016;
final heightValue502 = screenHeight / 1.1992;
final heightValue503 = screenHeight / 1.19682;
final heightValue504 = screenHeight / 1.19444;
final heightValue505 = screenHeight / 1.19208;
final heightValue506 = screenHeight / 1.18972;
final heightValue507 = screenHeight / 1.18738;
final heightValue508 = screenHeight / 1.18504;
final heightValue509 = screenHeight / 1.18271;
final heightValue510 = screenHeight / 1.18039;
final heightValue511 = screenHeight / 1.17808;
final heightValue512 = screenHeight / 1.17578;
final heightValue513 = screenHeight / 1.17349;
final heightValue514 = screenHeight / 1.17121;
final heightValue515 = screenHeight / 1.16893;
final heightValue516 = screenHeight / 1.16667;
final heightValue517 = screenHeight / 1.16441;
final heightValue518 = screenHeight / 1.16216;
final heightValue519 = screenHeight / 1.15992;
final heightValue520 = screenHeight / 1.15769;
final heightValue521 = screenHeight / 1.15547;
final heightValue522 = screenHeight / 1.15326;
final heightValue523 = screenHeight / 1.15105;
final heightValue524 = screenHeight / 1.14885;
final heightValue525 = screenHeight / 1.14667;
final heightValue526 = screenHeight / 1.14449;
final heightValue527 = screenHeight / 1.14232;
final heightValue528 = screenHeight / 1.14015;
final heightValue529 = screenHeight / 1.138;
final heightValue530 = screenHeight / 1.13585;
final heightValue531 = screenHeight / 1.13371;
final heightValue532 = screenHeight / 1.13158;
final heightValue533 = screenHeight / 1.12946;
final heightValue534 = screenHeight / 1.12734;
final heightValue535 = screenHeight / 1.12523;
final heightValue536 = screenHeight / 1.12313;
final heightValue537 = screenHeight / 1.12104;
final heightValue538 = screenHeight / 1.11896;
final heightValue539 = screenHeight / 1.11688;
final heightValue540 = screenHeight / 1.11481;
final heightValue541 = screenHeight / 1.11275;
final heightValue542 = screenHeight / 1.1107;
final heightValue543 = screenHeight / 1.10866;
final heightValue544 = screenHeight / 1.10662;
final heightValue545 = screenHeight / 1.10459;
final heightValue546 = screenHeight / 1.10256;
final heightValue547 = screenHeight / 1.10055;
final heightValue548 = screenHeight / 1.09854;
final heightValue549 = screenHeight / 1.09654;
final heightValue550 = screenHeight / 1.09455;
final heightValue551 = screenHeight / 1.09256;
final heightValue552 = screenHeight / 1.09058;
final heightValue553 = screenHeight / 1.08861;
final heightValue554 = screenHeight / 1.08664;
final heightValue555 = screenHeight / 1.08468;
final heightValue556 = screenHeight / 1.08273;
final heightValue557 = screenHeight / 1.08079;
final heightValue558 = screenHeight / 1.07885;
final heightValue559 = screenHeight / 1.07692;
final heightValue560 = screenHeight / 1.075;
final heightValue561 = screenHeight / 1.07308;
final heightValue562 = screenHeight / 1.07117;
final heightValue563 = screenHeight / 1.06927;
final heightValue564 = screenHeight / 1.06738;
final heightValue565 = screenHeight / 1.06549;
final heightValue566 = screenHeight / 1.0636;
final heightValue567 = screenHeight / 1.06173;
final heightValue568 = screenHeight / 1.05986;
final heightValue569 = screenHeight / 1.058;
final heightValue570 = screenHeight / 1.05614;
final heightValue571 = screenHeight / 1.05429;
final heightValue572 = screenHeight / 1.05245;
final heightValue573 = screenHeight / 1.05061;
final heightValue574 = screenHeight / 1.04878;
final heightValue575 = screenHeight / 1.04696;
final heightValue576 = screenHeight / 1.04514;
final heightValue577 = screenHeight / 1.04333;
final heightValue578 = screenHeight / 1.04152;
final heightValue579 = screenHeight / 1.03972;
final heightValue580 = screenHeight / 1.03793;
final heightValue581 = screenHeight / 1.03614;
final heightValue582 = screenHeight / 1.03436;
final heightValue583 = screenHeight / 1.03259;
final heightValue584 = screenHeight / 1.03082;
final heightValue585 = screenHeight / 1.02906;
final heightValue586 = screenHeight / 1.0273;
final heightValue587 = screenHeight / 1.02555;
final heightValue588 = screenHeight / 1.02381;
final heightValue589 = screenHeight / 1.02207;
final heightValue590 = screenHeight / 1.02034;
final heightValue591 = screenHeight / 1.01861;
final heightValue592 = screenHeight / 1.01689;
final heightValue593 = screenHeight / 1.01518;
final heightValue594 = screenHeight / 1.01347;
final heightValue595 = screenHeight / 1.01176;
final heightValue596 = screenHeight / 1.01007;
final heightValue597 = screenHeight / 1.00838;
final heightValue598 = screenHeight / 1.00669;
final heightValue599 = screenHeight / 1.00501;
final heightValue600 = screenHeight / 1.00333;
final heightValue601 = screenHeight / 1.00166;
final heightValue602 = screenHeight / 1;

// final textFieldBorder = OutlineInputBorder(
//   borderRadius: BorderRadius.all(
//     Radius.circular(screenWidth / 52.97),
//   ),
//   borderSide: const BorderSide(
//     color: Colors.transparent,
//   ),
// );

// final textFieldBorderEnabled = OutlineInputBorder(
//   borderRadius: BorderRadius.all(
//     Radius.circular(screenWidth / 52.97),
//   ),
//   borderSide: const BorderSide(
//     color: Colors.transparent,
//   ),
// );

// final textFieldBorderFocused = OutlineInputBorder(
//   borderRadius: BorderRadius.all(
//     Radius.circular(screenWidth / 52.97),
//   ),
//   borderSide: const BorderSide(
//     color: defaultAppColor,
//     width: 1.0,
//   ),
// );
