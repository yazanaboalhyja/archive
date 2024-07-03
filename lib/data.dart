import 'dart:ui';

import 'Models/VillageModel.dart';
import 'core/utils/assets.dart';
import 'core/utils/global_constants.dart';

List<Map<String,String>> MartyrsList =[
  {'full_name' : "الشهيد البطل أشرف نعالوة",
    "image_url" : "https://felesteen.news/thumb/w920/uploads/images/2022/10/BkCLs.jpg",
    "created_at": "2024-05-21",
  },
  {'full_name' : "الشهيد البطل المهندس يحيى عياش",
    "image_url" : "https://ramallah.news/uploads//images/b478df38065b24fd0a3cb20719276de2.jpg",
    "created_at": "2024-05-05",
  },
  {'full_name' : "الشهيد البطل إبراهيم النابلسي ",
    "image_url" : "https://ultrapal.ultrasawt.com/sites/default/files/inline-images/297167879_1222001255007552_8206232323779543416_n.jpeg"
 , "created_at": "2024-04-22",
  },
  {'full_name' : " الشهيد البطل أحمد نصر جرار",
    "image_url" : "https://www.noonpost.com/wp-content/uploads/2021/09/unnamed-5.png",
    "created_at": "2024-05-21",
  },
  {'full_name' : " الشهيد البطل عمر أبو ليلى",
    "image_url" : "https://images.alwatanvoice.com/news/large/9998960442.jpg",
    "created_at": "2024-04-22",
  },
];
List<Map<String,String>> PrisonersList =[
  {"name" : "عبد الله البرغوثي",
    "imageUrl" : "https://english.palinfo.com/wp-content/uploads//Models/Media/Images/2016/12/21/1286489682.jpg",
    "created_at": "2024-05-05",
  },
  {"name" : "أحمد مناصرة",
    "imageUrl" : "https://ichef.bbci.co.uk/ace/ws/426/cpsprodpb/4a32/live/9b54c910-8f98-11ee-ac7f-c97dfdb65d91.jpg",
    "created_at": "2024-05-08",
  },
  {"name" : "أيهم كممجي",
    "imageUrl" : "https://wafa.ps/imageUrl/NewsThumbImg/Default/965ef0ee-2059-45ed-98e9-5d7ac3a48f6e.png",
    "created_at": "2024-03-05",
  },
  {"name" : "مروان البرغوثي",
    "imageUrl" : "https://shuaanews.ps/wp-content/uploads/2024/04/%D8%A7%D9%84%D8%A3%D8%B3%D9%8A%D8%B1-%D9%85%D8%B1%D9%88%D8%A7%D9%86-%D8%A7%D9%84%D8%A8%D8%B1%D8%BA%D9%88%D8%AB%D9%8A.jpg"
 ,
    "created_at": "2024-04-05",

  },

];

List<Color> colors = [
  const Color(0xFFb8c2b7),
  const Color(0xFFb0d2c2),
  const Color(0xFFb9b6c1),
  const Color(0xFFB3E0B8),
  const Color(0xFFAEC4E0),
  const Color(0xFFC5AEE0),
  const Color(0xFFE0AEC4),
  const Color(0xFFb4b5b9),
  const Color(0xFFd2b48c),
  Color(0xff5e6152),
  Color(0xFF514CA5),
  Color(0xFFA54C93)
  //Colors.purple,
];
List<bool> willContainRow = [
  false,
  true,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];
List<Color> topIconsColor = [
  darken(const Color(0xFFb8c2b7), 0.2),
  darken(const Color(0xFFb0d2c2), 0.2),
  darken(const Color(0xFFb9b6c1), 0.2),
  darken(const Color(0xFFB3E0B8), 0.2),
  darken(const Color(0xFFAEC4E0), 0.2),
  darken(const Color(0xFFC5AEE0), 0.2),
  darken(const Color(0xFFE0AEC4), 0.2),
  darken(const Color(0xFFb4b5b9), 0.2),
  darken(const Color(0xFFd2b48c), 0.2),
];
 List<String> PreviousTitle = [
    "Total Transactions",
    "Total User Balance",
    "Total Users",
    "Wallet Fundings",
    "Debit Transactions",
    "Credit Transactions",
    "Airtime",
    "Data",
    "Electricity",
  ];
List<String> title = [
  "Total Martyrs",
  "Total Prisoners",
  "Total Users",
  "Total News",
  "Total Videos",
  "Total Village",
  "Verified Accounts",
  "Unverified Accounts",
];
final List<String?> topIcons = [
  null,
  nairaIcon,
  profileIcon,
  addIcon,
  null,
  null,
  mobileIcon,
  wifiIcon,
  electricityIcon,
];
List<Map<String,String>> LastNewsList =[
  {"title" : "قلق فلسطيني من موسم قطف الزيتون “دام” في الضفة الغربية",
    "content" : """حذر مسؤولون فلسطينيون امس(السبت) من موسم قطف زيتون “دام” في الضفة الغربية بسبب تصاعد “اعتداءات” المستوطنين الإسرائيليين على الفلسطينيين وممتلكاتهم.

ومن المقرر أن يبدأ موسم قطف الزيتون في الضفة الغربية منتصف أكتوبر القادم ويستمر لمدة 40 يوما، حيث يجني المزارعون محصولهم الذي يترقبونه على مدار عام كامل، أملا في أن يكون موسم سنوي مميز لهم اقتصاديا.

وقال غسان دغلس مسؤول ملف الاستيطان في شمال الضفة الغربية لوكالة أنباء ((شينخوا)) إن موسم قطف الزيتون سيكون “محفوف بالمخاطر” في ظل ارتفاع وتيرة اعتداءات المستوطنين في الضفة.

وذكر دغلس أن المستوطنين نفذوا أكثر من ألف “اعتداء” على الفلسطينيين منذ بداية العام في الضفة شملت حرق وقطع أشجار زيتون وإغلاق طرقات وهجوم على منازل بحماية من قوات الجيش الإسرائيلي.

وتابع أن أكثر المدن عرضة للممارسات هي نابلس وسلفيت وقلقيلية وطولكرم، مشيرا إلى أن هيئة مقاومة الجدار والاستيطان ستعمل على تنظيم أيام تطوعية لمساندة المزارعين في كافة المناطق والمدن.

وأشار إلى أن الهيئة والفصائل الفلسطينية ستقوم بتشكيل مجموعات شبابية من أجل الرباط في المناطق الأكثر اعتداء لمساندة المزارعين الذين يمتلكون أراضي قريبة من المستوطنات.

وتحتل شجرة الزيتون مكانة كبيرة لدى الفلسطينيين خاصة في موسم حصاده، ويعيش في الضفة الغربية التي احتلتها إسرائيل في العام 1967 أكثر من نصف مليون مستوطن إسرائيلي إلى جانب 3.1 مليون فلسطيني، وكثيرا ما تحولت المواجهات بين الجانبين إلى أعمال عنف.

وقال مراد اشتيوي منسق المقاومة الشعبية في شمال الضفة لـ ((شينخوا)) إن المستوطنين يشنون حملة اعتداءات على المزارعين وأراضيهم تزداد في موسم قطف الزيتون الذي يشكل مصدر دخل لنحو 100 ألف أسرة فلسطينية.

وأضاف اشتيوي أن المزارع الفلسطيني ينتظر عاما كاملا ويعتني بأرضه من أجل حصاد محصول الزيتون، مشيرا إلى أن شجرة الزيتون لديها قيمة وطنية وثقافية لدى الشعب الفلسطيني.

وبحسب مصادر إسرائيلية وفلسطينية فإن أكثر من 600 ألف مستوطن إسرائيلي يتواجدون في 164 مستوطنة و124 بؤرة استيطانية في الضفة الغربية والقدس.

وفي هذا الصدد قال رئيس هيئة مقاومة الجدار والاستيطان في منظمة التحرير الفلسطينية مؤيد شعبان إن الهيئة وضعت خطة لعدم الوصول المستوطنين للمزارعين الفلسطينيين وأراضيهم بسهولة والاستفراد بهم.

وذكر شعبان للصحفيين في رام الله أن الهيئة ستدعو لجان المقاومة الشعبية والفصائل الفلسطينية والمؤسسات الشعبية والجامعات في الضفة لوضع تفاصيل الخطة التي تركز على المناطق المحاذية للمستوطنات بأن يكون قطف ثمار الزيتون جماعيا وأن لا يذهب كل مزارع لوحده.

وتابع أن موسم قطف الزيتون لهذا العام “لن يكون عاديا وسيكون داميا في ظل توفير الجيش الإسرائيلي حماية للمستوطنين من أجل تنفيذ اعتداءاتهم ضد الفلسطينيين وممتلكاتهم وأراضيهم”.

وأشار شعبان إلى أن ممارسات المستوطنين تزداد “عنف” عام بعد أخر، ولكن موسم قطف الزيتون هذا العام سيكون مختلفا وسيتم استغلاله مع قرب إجراء الانتخابات الإسرائيلية المقررة في نوفمبر المقبل.""",
    "imageUrl" : "https://www.barakabits.com/wp-content/uploads/2016/08/blog02-530x350.jpg"

    ,"category" : "Economy",
    "author" : "Ibraheem AbdAlhadi",
    "date" : "10/4/2024",
    "Source" :"القدس دوت كوم",
    "posturl" : "https://hayat.ps/%D9%82%D9%84%D9%82-%D9%81%D9%84%D8%B3%D8%B7%D9%8A%D9%86%D9%8A-%D9%85%D9%86-%D9%85%D9%88%D8%B3%D9%85-%D9%82%D8%B7%D9%81-%D8%A7%D9%84%D8%B2%D9%8A%D8%AA%D9%88%D9%86-%D8%AF%D8%A7%D9%85-%D9%81%D9%8A/"
  },
  {"title" : "السابع من اكتوبر.. الشعب الفلسطيني يحيي يوم التراث للتأكيد على الهوية الوطنية",
    "content" : """ يحيي شعبنا في السابع من شهر تشرين أول من كل عام، يوم التراث الفلسطيني، من خلال تنظيم أنشطة وفعاليات بهدف الحفاظ عليه من النسيان والسرقة.

وحكاية يوم التراث الفلسطيني ترجع للمؤرخ نمر سرحان (مؤلف موسوعة الفلكلور الفلسطيني)، الذي فكر في صيف عام 1966 أن يعد لإذاعة "صوت فلسطين" من القدس برنامجًا عن القرية الفلسطينية بعنوان "قريتي هناك"، يتحدث فيها عن الأغاني الشعبية والموسيقى في القرى الفلسطينية، وبدأ رحلته في البحث والدراسة وجمع الفلكلور الفلسطيني من أغانٍ شعبية، وأهازيج، وتهاليل، وعادات وتقاليد، وألعاب، ومأكولات شعبية، بشكل أكاديمي.

بدأ المؤرخ سرحان إصدار موسوعة الفلكلور الفلسطيني عام 1977، ومع صدور الجزء الخامس يوم 1 تموز 1981، بمشاركة من لجنة إعداد الموسوعة؛ ودعم من "الاتحاد العام للكتاب والصحفيين الفلسطينيين"- تقرر اعتماد هذا اليوم من كل سنة يومًا للاحتفال بيوم التراث الفلسطيني؛ بهدف الحفاظ على الموروث الثقافي من التهويد والسرقة التي تقوم بها سلطات الاحتلال الإسرائيلي.

وفي وقت لاحق وبناء على توصية وزارة الثقافة، قرر مجلس الوزراء في 14 أيار 1999 بأن يكون يوم السابع من تشرين الأول من كل عام "يوم التراث الفلسطيني"، بدلا من يوم 1 تموز؛ لأن الطلاب يكونوا قد انتظموا في مدارسهم، فيسهل إحياء هذا اليوم بشكل أكثر فعالية؛ إضافة إلى أن شهر تشرين الأول هو موسم قطاف الزيتون؛ فلشجرة الزيتون رمزية واضحة على العطاء والصمود والتشبث بالأرض والتجذر بها.

التراث الفلسطيني يعدّ من المرتكزات الأساسية للهوية الفلسطينية، إذ تتجلى في جل مكوناته خصوصيتنا كشعب عريق في تراثنا المادي وغير المادي، الضارب جذوره في عمق التاريخ، منذ أجدادنا الكنعانيين.

ويمثل التراث الشعبي الفلسطيني ثروة ضخمة من الأدب والقيم والعادات والتقاليد والمعارف الشعبية والثقافية والفنون التشكيلية والطقوس الدينية، والحكايات، والأمثال، والأحاجي والألغاز، والألعاب الشعبية، والأكلات، والملابس، والدبكة، والأغاني، والموسيقى الشعبية؛ إضافة إلى الفن المعماري الفلسطيني؛ لذلك علينا بذل الجهود الجبارة للمحافظة على التراث من الضياع من خلال حمايته على الصعيد الوطني والعالمي.

وهنا لا بد من الإشارة إلى تبني منظمة الأمم المتحدة للتربية والعلوم والثقافة (اليونسكو) يوم 18 تشرين الأول 2016 - خلال اجتماع لها في العاصمة الفرنسية باريس- قرارًا ينفي وجود ارتباط ديني لليهود بـالمسجد الأقصى وحائط البراق، ويعتبرهما تراثًا إسلاميًا خالصًا؛ ويرفض الإجراءات الإسرائيلية الأحادية الجانب.

كما أنه في يوم 12/3/2018، أعلنت جامعة الدول العربية اعتماد القدس "عاصمة دائمة للتراث العربي"؛ كما تحدد يوم التراث العربي في عام 2019 ليكون يومًا للتراث المقدسي.

إن المحافظة على التراث الفلسطيني في وجه كل المحاولات الإسرائيلية المعادية لطمسه وسرقته يعني ضمان الحفاظ على وجودنا واستمراريتنا وسر بقائنا على هذه الأرض.

وأكدت وزارة الثقافة، في بيان لها لهذه المناسبة، اليوم الجمعة، أن تراثنا سيظل عنوان هويتنا ومصدرا أساسيا لحكاية وجودنا على هذه الأرض وحافظ الرواية الوطنية، والحكاية الجمعية، والسردية الفلسطينية الخالصة، وهو بحمولته تلك يشكل سيرة ومسيرة ومسارا، يحافظ على الهوية الوطنية في سيرته، ويعمل في مسيرته على تجذير وتكريس الوعي الجمعي في إطار الثقافة الوطنية الجامعة، ويشكل مسارا حول فلسطين كواحدة من أهم حواضر الكون في الوعي والثقافة والتاريخ والمعرفة، والتي تساهم فعلا في الحضارة الكونية، بصفتها محطة إنسانية أولى، كانت ولا زالت حاضنة التاريخ والتراث الإنساني الكوني.

وأضافت أن التراث هو النص الأساس لخطاب الثقافة الوطنية، الذي يبرهن على حق الفلسطيني، وحقيقته الدامغة، في المكان والزمان، ويؤكد فاعلية وقدرة الثقافة الفلسطينية في تكريس وتمتين الوعي الوطني، وبناء الجسر المتين الذي يحمل الماضي بعراقته وأصالته إلى الحاضر بجسارته في ديمومة المسير إلى المستقبل المشتهى.

وقالت إن يوم التراث الفلسطيني يؤصل منهجية لاستدامة الوعي والمعرفة، كروافع قيمية ذات مضمون وطني يتماهى بشكل طبيعي مع نضال الشعب العربي الفلسطيني، وإسهامه في الدفاع عن القيم الإنسانية، ويقدم فلسطين كحاضرة كونية ملهمة، محمولة على قوة الحق التاريخي في مواجهة حق القوة الغاشمة، من أجل حاضر سليم ومستقبل حر، نستمد فيه قدرتنا على الفعل والتأثير من حكايةٍ تحفر عميقاً في الأرضِ والذاكرة بعمق ِجذرنا الرئيس في تاريخ كنعان على هذه الأرض.

وتابعت: كما يأتي يوم التراث الفلسطيني، حاملاً بفخر الشراكة التامة والبناءة في الفعل الوطني الفلسطيني مكرسا في التفاعل بين المؤسسات الرسمية والوطنية والتربوية وأهمية دورها في تعزيز الحفاظ على الموروث الثقافي، وتكريس فعله من أجل تأطير العمل الخاص به سواء كان على مستوى الأفراد والجماعات أو المؤسسات، حيث تقف وزارة الثقافة داعمة لهذا الفعل من خلال توفير عوامل ومقومات نجاح الدورِ المنوط بها على الصعيدَيْن المادي والمعنوي، الذي يتمثل في فتح الآفاق أمام كافة العاملات والعاملين والمنشغلين بالتراث لتحقيق حضورهم على مختلف الأصعدة المحلية والعربية والدولية، كونَ التراث الفلسطيني يمثل المخزون التاريخي لشعبنا الفلسطيني، ويمثل العُمق الحضاري الذي يزخر به نتيجةً لتعاقب الحضارات الإنسانية التي تأثَّرت وأثَّرت به.

وأشارت الوزارة إلى أنها ستطلق فعاليات يوم التراث الفلسطيني هذا العام من نبع تل السلطان في أقدم مدينة بالتاريخ، مدينة القمر أريحا، التي تؤرخ للبشرية في حضارتها كأول تجمع مدني حضاري سكاني في التاريخ، ويحمل ذكريات الأجداد الفلسطينيين الأوائل.

وبينت الوزارة أن هذه الفعاليات تعكس رؤيتها في تكريس حرصها وحرص المؤسسات الوطنية كافة على جعل الثقافة عاملًا أساسيًّا من عوامل التحرر من الاستعمار، وهذا ما يمثله دور المبدعات والمبدعين الفلسطينيين، والمتمثل بكفاحهم البطولي في الحفاظ على الرواية الفلسطينية وتمكينها وتمتينها وصقلها من أجل مواجهة حرب الإلغاء والمحو والسلب والنهب، التي يمارسها الاحتلال الإسرائيلي من خلال سطوه على الأرض والتاريخ والشواهد والأسماء التي ورثناها تمامًا كما ترث الأرضُ ترابَها، هذه المواجهة التي تخوضها أجيالنا  فـ"أجيالنا حرّاس التراث".

 وأوضحت أنها ستخصص هذا العام جهدا نوعيا في موضوع الدبكة الفلسطينية، كعنصر تسعى الوزارة لتسجيله في القائمة التمثيلية لعناصر التراث الثقافي غير المادي للبشرية لدى "اليونسكو".""",
    "imageUrl" : "https://www.aaup.edu/sites/default/files/1_3.JPG"

    ,"category" : "Cultural Events",
    "author" : "Ali Shadid",
    "date" : "15/4/2024",
    "Source" :" فتح ميديا",
    "posturl" : "https://www.fatehgaza.com/ar/post/61724/%D8%A7%D9%84%D8%B3%D8%A7%D8%A8%D8%B9-%D9%85%D9%86-%D8%A7%D9%83%D8%AA%D9%88%D8%A8%D8%B1-%D8%A7%D9%84%D8%B4%D8%B9%D8%A8-%D8%A7%D9%84%D9%81%D9%84%D8%B3%D8%B7%D9%8A%D9%86%D9%8A-%D9%8A%D8%AD%D9%8A%D9%8A-%D9%8A%D9%88%D9%85-%D8%A7%D9%84%D8%AA%D8%B1%D8%A7%D8%AB-%D9%84%D9%84%D8%AA%D8%A3%D9%83%D9%8A%D8%AF-%D8%B9%D9%84%D9%89-%D8%A7%D9%84%D9%87%D9%88%D9%8A%D8%A9-%D8%A7%D9%84%D9%88%D8%B7%D9%86%D9%8A%D8%A9"

  },


];
List<String> NewsCategory =[
  "General",
  "Business",
  "Sport",
  "Art",
  "Education",
  "Humanitarian Efforts",
  "Diplomatic Initiatives",
  "Cultural Events",
  "Health",
];

List<VillageModel> villagedData = [
  VillageModel(
    submitted_by_name: '',
      id: 1,
      created_at: '0000-00-00',
      village_name: "قرية عمواس",
      image_url:
      "https://www.alaraby.co.uk/sites/default/files/media/images/B24C0C00-737E-42FF-9029-42560065A448.jpeg",
      city: "مدينة الرملة",
      historical_context:
      """عمواس قرية فلسطينية احتلت عام 1967 ودمرها الجيش الإسرائيلي وطرد أهلها (ذات المصير أصاب قريتي يالو وبيت نوبا في منطقة اللطرون)، كانت تقع في منطقة اللطرون جنوب شرق الرملة، وكانت تقع على مفترق طرق يوصل بين مدن رئيسية هي: رام الله والرملة ويافا والقدس وغزة. تبعد عن يافا حوالي 30 كم ومثل ذلك تقريباً عن القدس. قبل النكبة كانت تربطها طرق ممهدة بقرى اللطرون ويالو والقباب وسلبيت ودير أيوب وبيت سوسين وبيت جيز. ترتفع عن سطح البحر 230 متراً.

تاريخ عمواس
«عمواس» بمعنى الينابيع الحارة بلد قديم. كان اسمها في العهد الروماني «نيقوبوليس» بمعنى مدينة النصر نسبة إلى انتصار فاسبسيانوس على اليهود خلال الثورة اليهودية الكبرى. وصلها المسلمون في خلافة أبي بكر حيث فتحها عمرو بن العاص بعد استيلائه على اللد ويبنا. أصبحت مقر جند المسلمين. انتشر فيها الطاعون في زمن عمر بن الخطاب ومنها إنتشر إلى سائر بلاد الشام ومات فيه آلاف كثيرة من الناس وسمي طاعون عمواس.

في عمواس كنيسة بيزنطية أعاد الفرنج بناءها في القرن الثاني عشر للميلاد إبان الحملات الصليبية. دير اللطرون الواقع في جوار عمواس، أقامه رهبان الترابيست عام 1890 للميلاد، وهم رهبان كاثوليك سمّوا كذلك نسبة إلى دير «تراب» في فرنسا.

عمواس في ألإنجيل
ذُكرت في الإنجيل في لوقا ١٣: ٢٤-٣٥ على انها قرية تبعد ستين غلوة عن القدس؛ إلا أن شكوكًا تدور فيما إذا كان المكان المقصود قرية أبو غوش أو عمواس نيكوبوليس (Emmaus Nicopolis) أو القبيبة؛ اكتشف علماء الآثار مؤخرًا حصناً تاريخيًا قد يساعد في تحديد موقع عمواس التي وردت في الإنجيل.

المساحة والسكان

منظر عام لقرية عمواس في عام 1958. وتظهر معالم القرية قبل التدمير الأسرائيلي في عام 1967
تملك عمواس أكثر من 5000 آلاف دونم. اعتاد أهلها زراعة الحبوب والبقول. بها أشجار لوز وتين وعنب وصبار وزيتون. وفي عمواس وحولها ينابيع استفاد منها السكان للشرب وغيره، أشهرها «بئر الحلوة» الواقع بجانب دير اللطرون.

كان في عمواس عام 1922 نحو 824 نسمة وفي عام 1931 نحو 1021 شخصاً عاشوا في 224 بيتاً وفي عام 1945 قدروا ب 1450 نسمة، وصل عددهم حسب تعداد أجري في 18 نوفمبر 1961 إلى 1955 نسمة. معظم السكان يعودون بأصلهم إلى عائلة الشيخ ومنها مختار عمواس وعائلتي برغش وأبو غوش التي تبعد 15 كم عن عمواس باتجاه القدس. ولهاتين العائلتين أبناء عم في الأردن وهم عشائر البطاينة والسيوف وآل أبوبكر وفرعهم آل الأحمد وجميعهم من قبيلة شمر الطائية.

في عمواس مسجدان ومدرسة ابتدائية للبنين أسست سنة 1919 بمعلم واحد. وبعد النكبة أصبح فيها مدرستان واحدة للبنات والأخرى للبنين. وتحتوي عمواس أيضاً على كنيسة متهدمة وهياكل فسيفساء ومدافن قديمة وقناة منقورة في الصخر وبقايا حمام روماني وآثار معمارية كثيرة ومقامات وأضرحة مقدسة ينسب أحدها إلى الصحابي أبي عبيدة عامر بن الجراح رغم كونه غير مدفون هناك وينسب مقام «الشيخ معلّى» إلى الصحابي معاذ بن جبل.


قرية عمواس بعد تدميرها عام 1967
التهجير عام 1967
هدم الاحتلال قرية عمواس في حزيران 1967 وقد مر بها بعد خرابها الصحفي البريطاني مايكل آدمز ووصفها في تقرير نشر في صحيفة الصنداي تايمز جاء فيه:

«وكانت الطريق التي نسير عليها هي طريق عمواس. ولكن عندما انطلقنا بالسيارة من بيت نوبا ووصلنا إلى المنحنى الذي تقع عمواس عليه، وجدنا أن عمواس قد اختفت وزالت من الوجود تماماً.»
                    """,
      bgColor: const Color(0xff5e6152),
      current_status: '', views: 0, submitted_by: 2),
  VillageModel(
      submitted_by_name: '',
      id: 1,
      created_at: '0000-00-00',
      village_name: "قرية لفتا",
      image_url:
      "https://assets.nn.najah.edu/CACHE/images/uploads/weblog/2021/02/08/6a80c8a9-4222-457d-a988-9599b84861c4/4b9ece1ffd4a8a8c7906842965de9d65.jpeg",
      city: "Eastern South America",
      historical_context:
      "Blue parrot species range from small to very large in size and come in powdery light blues to deep indigos. Some of these birds simply have flashy blue markings while others are predominantly blue.",
      bgColor: const Color(0xFF514CA5), current_status: '', views: 0, submitted_by: 2),
  VillageModel(
      submitted_by_name: '',
      id: 1,
      created_at: '0000-00-00',
      village_name: "قرية عكبرة",
      image_url:
      "https://palqura.com/images/village/%D8%B9%D9%83%D9%83%D9%83.jpg",
      city: "South and North America",
      historical_context:
      "The roseate spoonbill is a gregarious wading bird of the ibis and spoonbill family, Threskiornithidae. It is a resident breeder in both South and North America.",
      bgColor: const Color(0xFFA54C93), current_status: '', views: 0, submitted_by: 1),
];

