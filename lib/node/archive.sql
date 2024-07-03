-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 26, 2024 at 01:12 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `archive`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `user_id`) VALUES
(1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` int(11) NOT NULL,
  `question` text DEFAULT NULL,
  `answer` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `language` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `question`, `answer`, `created_at`, `language`) VALUES
(1, 'متى حدثت معركة العصف المأكول', 'في عام  2012', '2024-06-05 09:18:56', 'ar'),
(2, 'when was tofanalaqsa ?', '2024', '2024-06-06 08:14:38', 'en'),
(3, 'What are the most prominent historical landmarks in Palestine?\r\n', 'Al-Aqsa Mosque and the Dome of the Rock in Jerusalem, the Church of the Nativity in Bethlehem, the Church of the Holy Sepulchre in Jerusalem, the ancient city of Jericho, Mount Gerizim in Nablus, and the Ibrahimi Mosque in Hebron\n', '2024-06-25 22:53:07', 'en'),
(4, 'What are the traditional Palestinian dishes?\r\n', 'Musakhan, Maqluba, Kibbeh, Fattoush, Mansaf, Hummus, Falafel, and Za\atar with olive oil\r\n', '2024-06-25 22:53:07', 'en'),
(5, 'What are the main cities in Palestine?\r\n', ' Jerusalem, Ramallah, Nablus, Gaza, Bethlehem, Hebron, and Jericho\n', '2024-06-25 22:53:20', 'en'),
(6, 'What are the environmental challenges facing Palestine?\r\n', 'pollution from industrial activities and settlements, water resource shortages, agricultural land degradation, and climate change\r\n', '2024-06-25 22:53:53', 'en'),
(7, 'What are the main tourist sites in Palestine?\r\n', 'Old City of Jerusalem, the Dead Sea, the Church of the Nativity in Bethlehem, Al-Aqsa Mosque, the ancient city of Jericho, and the archaeological site of Sebastia\r\n', '2024-06-25 22:53:53', 'en'),
(8, 'What are the popular sports in Palestine?\r\n', 'football (soccer), basketball, volleyball, and athletics.\r\n', '2024-06-25 22:54:07', 'en'),
(9, 'What are the main educational institutions in Palestine?\r\n', 'Birzeit University, An-Najah National University, Al-Quds University, Bethlehem University, and the Islamic University of Gaza\r\n', '2024-06-25 22:54:31', 'en'),
(10, 'What are the leading research innovations coming from Palestine?\r\n', 'development of sustainable agricultural technologies, research in renewable energy fields, and the use of technology in education and healthcare\r\n', '2024-06-25 22:54:31', 'en'),
(11, 'What are the customs and traditions that were characteristic of village residents before migration?\r\n', 'The customs and traditions unique to the villagers included collective farming, seasonal celebrations such as harvest season, traditional weddings, and religious and social event\r\n', '2024-06-25 22:54:54', 'en'),
(12, 'What were the infrastructural sites in the village like schools, hospitals, and mosques?\r\n', 'The infrastructural sites in the villages included schools providing basic education, mosques serving as religious and social centers, and hospitals or health clinics providing medical care\r\n', '2024-06-25 22:54:54', 'en'),
(13, 'What changes occurred in the structure of the village after migration?\r\n', ' destruction or repurposing of some buildings, the conversion of agricultural land for other projects\r\n', '2024-06-25 22:55:18', 'en'),
(14, 'What economic activities were the village witnessing before migration?\r\n', 'agriculture, livestock farming, handicrafts, and local trade\r\n', '2024-06-25 22:55:18', 'en'),
(15, 'What are the stories of some prominent martyrs whose sacrifices have been documented on the Martyrs\ Memorial Page?\r\n', 'The stories of some prominent martyrs include their sacrifices in resisting occupation, defending their village and land, and the impact they left on the community after their martyrdom.\r\n', '2024-06-25 22:55:38', 'en'),
(16, 'What are the humanitarian conditions faced by prisoners in prisons?\r\n', 'overcrowding in cells, lack of healthcare, physical and psychological torture, and deprivation of basic rights\r\n', '2024-06-25 22:55:38', 'en'),
(17, 'Do prisons comply with providing necessary healthcare to prisoners?\r\n', 'Many prisons do not comply with providing necessary healthcare to prisoners, as inmates suffer from a lack of medical services and medications\r\n', '2024-06-25 22:56:00', 'en'),
(18, 'What are the health challenges that prisoners may face in prisons?\r\n', 'The health challenges that prisoners may face include chronic diseases, injuries resulting from torture, infectious diseases, and malnutrition\r\n', '2024-06-25 22:56:00', 'en'),
(19, ' What psychological and social services are available to prisoners in prisons?\r\n', 'The psychological and social services available to prisoners are often limited or unavailable, negatively affecting their mental and social health\r\n', '2024-06-25 22:56:20', 'en'),
(20, 'Are there specific procedures for dealing with sick prisoners or those with special needs?\r\n', 'The procedures for dealing with sick prisoners or those with special needs are often inadequate, leading to a deterioration in their health conditions\r\n', '2024-06-25 22:56:20', 'en'),
(21, 'Do prisoners have the opportunity for legal defense and consultation?\r\n', 'Many prisoners do not get sufficient opportunities for legal defense and consultation, exposing them to unfair trials.\r\n', '2024-06-25 22:56:40', 'en'),
(22, 'Do prisons adhere to international human rights standards in the treatment of prisoners?\r\n', 'Many prisons do not adhere to international human rights standards in the treatment of prisoners, with inmates experiencing multiple human rights violations\r\n', '2024-06-25 22:56:40', 'en'),
(23, 'Are the political, cultural, and religious rights of prisoners respected?\r\n', 'Often, the political, cultural, and religious rights of prisoners are not respected, leading to violations of their fundamental freedoms\r\n', '2024-06-25 22:57:00', 'en'),
(24, 'Do prisoners have opportunities for education and cultural development in prisons?\r\n', 'Prisoners rarely have opportunities for education and cultural development in prisons, affecting their personal and cultural growth.\r\n', '2024-06-25 22:57:00', 'en'),
(25, '\"What educational activities can be conducted in schools to introduce students to the martyrs?\r\n\"\r\n', '\"Organize seminars and lectures given by experts or family members of the martyrs to talk about their lives and sacrifices.\r\nPrepare research projects by students about the martyrs, their stories, and their impact on Palestinian society.\r\nOrganize visits to memorials or places related to the martyrs to enhance awareness of their sacrifices.\r\nSet up exhibitions with photos and documents that tell the stories of the martyrs and their impact.\r\nEncourage students to write essays or poems commemorating the martyrs and highlighting the importance of their sacrifices.\r\n\"\r\n', '2024-06-25 22:57:22', 'en'),
(26, 'What are the psychological and social impacts on the families of the martyrs?\r\n', 'The families of the martyrs suffer from separation from their children, but they cannot bear the loss of their children for the sake of truth and society is in solidarity with them and supports them.\r\n', '2024-06-25 22:57:22', 'en'),
(27, 'What places are named after martyrs to honor them?\r\n', '\"Many schools and universities are named after martyrs to honor their sacrifices.\r\nSome streets and public squares are named after martyrs to commemorate their memory in the community.\r\nCultural and sports centers are named after martyrs to honor them and contribute to cultural heritage.\r\nMartyrs\ names are given to mosques and religious buildings to commemorate their sacrifices.\r\n', '2024-06-25 22:57:56', 'en'),
(28, 'Are there memorials for the martyrs in Palestine?\r\n', '\"Yes, there are many memorials for the martyrs in Palestine to honor their sacrifices.\r\nThese memorials include statues and engravings bearing the names of the martyrs and telling their stories.\r\nIn some cities, public squares include memorials for the martyrs used for national events and commemorative occasions.\r\nRegular visits to these memorials are organized by community members and schools to raise awareness of the martyrs\ history and sacrifices.\r\n\r\n\r\n\r\n\r\n\\r\n', '2024-06-25 22:57:56', 'en'),
(29, 'ما هي أبرز المعالم التاريخية في فلسطين؟\r\n', 'المسجد الأقصى وقبة الصخرة في القدس، وكنيسة المهد في بيت لحم، وكنيسة القيامة في القدس، ومدينة أريحا التاريخية، وجبل جرزيم في نابلس، والمسجد الإبراهيمي في الخليل.\r\n', '2024-06-25 23:04:54', 'ar'),
(30, 'ما هي الأكلات التقليدية الفلسطينية؟\r\n', 'المسخن، والمقلوبة، والكبة، والفتوش، والمنسف، والحمص، والفلافل، والزعتر مع الزيت.\r\n', '2024-06-25 23:04:54', 'ar'),
(31, 'ما هي المدن الرئيسية في فلسطين؟\r\n', 'القدس، ورام الله، ونابلس، وغزة، وبيت لحم، والخليل، وأريحا.\r\n', '2024-06-25 23:05:06', 'ar'),
(32, 'ما هي التحديات البيئية التي تواجهها فلسطين؟\r\n', 'التلوث الناتج عن النشاطات الصناعية والمستوطنات، نقص الموارد المائية، تدهور الأراضي الزراعية، والتغير المناخي.\r\n', '2024-06-25 23:05:26', 'ar'),
(33, 'ما هي أهم المواقع السياحية في فلسطين؟\r\n', 'البلدة القديمة في القدس، البحر الميت، كنيسة المهد في بيت لحم، المسجد الأقصى، مدينة أريحا القديمة، ومدينة سبسطية الأثرية.\r\n', '2024-06-25 23:05:26', 'ar'),
(34, 'ما هي الألعاب الرياضية الشعبية في فلسطين؟\r\n', 'كرة القدم، كرة السلة، الكرة الطائرة، وألعاب القوى.\r\n', '2024-06-25 23:05:38', 'ar'),
(35, 'ما هي أهم المؤسسات التعليمية في فلسطين؟\r\n', 'جامعة بيرزيت، وجامعة النجاح الوطنية، وجامعة القدس، وجامعة بيت لحم، والجامعة الإسلامية في غزة.\r\n', '2024-06-25 23:05:59', 'ar'),
(36, 'ما هي الابتكارات البحثية الرائدة التي تأتي من فلسطين؟\r\n', 'تطوير تقنيات زراعية مستدامة، أبحاث في مجالات الطاقة المتجددة، واستخدام التكنولوجيا في التعليم والرعاية الصحية.\r\n', '2024-06-25 23:05:59', 'ar'),
(37, 'ما هي العادات والتقاليد التي كانت مميزة لسكان القرى قبل الهجرة؟\r\n', 'الزراعة الجماعية، الاحتفالات الموسمية مثل موسم الحصاد، الأعراس التقليدية، والمناسبات الدينية والاجتماعية.\r\n', '2024-06-25 23:06:28', 'ar'),
(38, 'كيف كانت مواقع البنية التحتية في القرية مثل المدارس والمستشفيات والمساجد؟\r\n\r\n', ' المدارس التي تقدم التعليم الأساسي، المساجد كمراكز دينية واجتماعية، والمستشفيات أو العيادات الصحية لتوفير الرعاية الطبية.\r\n', '2024-06-25 23:06:28', 'ar'),
(39, 'ما هي التغييرات التي طرأت على بنية القرية بعد الهجرة؟\r\n', 'تدمير بعض المباني أو تحويلها لأغراض أخرى، تحويل الأراضي الزراعية لمشاريع أخرى\r\n', '2024-06-25 23:06:52', 'ar'),
(40, 'ما هي الأنشطة الاقتصادية التي كانت تشهدها القرية قبل الهجرة؟\r\n', 'الزراعة، تربية المواشي، الحرف اليدوية، والتجارة المحلية.\r\n', '2024-06-25 23:06:52', 'ar'),
(41, 'ما هي قصص بعض الشهداء البارزين الذين تم توثيق تضحياتهم على صفحة الشهداء؟\r\n', 'قصص بعض الشهداء البارزين تشمل تضحياتهم في مقاومة الاحتلال، دفاعهم عن قريتهم وأرضهم، والأثر الذي تركوه في المجتمع بعد استشهادهم.\r\n', '2024-06-25 23:07:21', 'ar'),
(42, 'ما هي الظروف الإنسانية التي يواجهها الأسرى في السجون؟\r\n', 'الاكتظاظ في الزنازين، نقص الرعاية الصحية، التعذيب الجسدي والنفسي، والحرمان من الحقوق الأساسية.\r\n', '2024-06-25 23:07:21', 'ar'),
(43, 'هل تلتزم السجون بتوفير الرعاية الصحية اللازمة للأسرى؟\r\n', 'لا تلتزم العديد من السجون بتوفير الرعاية الصحية اللازمة للأسرى، حيث يعاني الأسرى من نقص في الخدمات الطبية والأدوية.\r\n', '2024-06-25 23:07:44', 'ar'),
(44, 'ما هي التحديات الصحية التي يمكن أن تواجه الأسرى في السجون؟\r\n', 'التحديات الصحية التي يمكن أن تواجه الأسرى تشمل الأمراض المزمنة، الإصابات الناتجة عن التعذيب، الأمراض المعدية، وسوء التغذية.\r\n', '2024-06-25 23:07:44', 'ar'),
(45, 'ما هي الخدمات النفسية والاجتماعية المتاحة للأسرى في السجون؟\r\n', 'الخدمات النفسية والاجتماعية المتاحة للأسرى غالبًا ما تكون محدودة أو غير متوفرة، مما يؤثر سلبًا على صحتهم النفسية والاجتماعية.\r\n', '2024-06-25 23:08:06', 'ar'),
(46, 'هل هناك إجراءات محددة للتعامل مع الأسرى المرضى أو ذوي الاحتياجات الخاصة؟\r\n', 'الإجراءات المتبعة للتعامل مع الأسرى المرضى أو ذوي الاحتياجات الخاصة غالبًا ما تكون غير كافية، مما يؤدي إلى تدهور حالتهم الصحية.\r\n', '2024-06-25 23:08:06', 'ar'),
(47, 'هل يحصل الأسرى على فرصة للدفاع والاستشارة القانونية؟\r\n', 'العديد من الأسرى لا يحصلون على فرصة كافية للدفاع والاستشارة القانونية، مما يعرضهم لمحاكمات غير عادلة.\r\n', '2024-06-25 23:08:25', 'ar'),
(48, 'هل تلتزم السجون بمعايير حقوق الإنسان الدولية في معاملة الأسرى؟\r\n', 'العديد من السجون لا تلتزم بمعايير حقوق الإنسان الدولية في معاملة الأسرى، حيث يتعرض الأسرى لانتهاكات حقوقية متعددة.\r\n', '2024-06-25 23:08:25', 'ar'),
(49, 'هل يتم احترام حقوق الأسرى السياسية والثقافية والدينية؟\r\n', 'في كثير من الأحيان، لا يتم احترام حقوق الأسرى السياسية والثقافية والدينية، مما يؤدي إلى انتهاك حرياتهم الأساسية.\r\n', '2024-06-25 23:08:46', 'ar'),
(50, 'هل يحصل الأسرى على فرص للتعليم والتطوير الثقافي داخل السجون؟\r\n', 'الأسرى نادرًا ما يحصلون على فرص للتعليم والتطوير الثقافي داخل السجون، مما يؤثر على نموهم الشخصي والثقافي.\r\n', '2024-06-25 23:08:46', 'ar'),
(51, 'ما هي الأنشطة التعليمية التي يمكن أن تُجرى في المدارس لتعريف الطلاب بالشهداء؟\r\n', '\يمكن تنظيم ندوات ومحاضرات يقدمها مختصون أو أفراد من عائلات الشهداء للتحدث عن حياتهم وتضحياتهم.\r\nإعداد مشاريع بحثية يقدمها الطلاب حول الشهداء وقصصهم وتأثيرهم على المجتمع الفلسطيني.\r\nتنظيم زيارات إلى نصب تذكارية أو أماكن ذات صلة بالشهداء لتعزيز الوعي بأهمية تضحياتهم.\r\nإقامة معارض تحتوي على صور ووثائق تروي قصص الشهداء وأثرهم.\r\nتشجيع الطلاب على كتابة مقالات أو قصائد تخلد ذكرى الشهداء وتوضح أهمية تضحياتهم\r\n', '2024-06-25 23:08:54', 'ar'),
(52, 'ما هي الآثار النفسية والاجتماعية على عائلات الشهداء؟\r\n', 'يعاني اهالي الشهداء من فراق ابانئهم ولكن ما يصبرهم انهم فقدو ابنائهم من اجل الحق و المجتمع يكون متضامن معهم و يدعمهم\r\n', '2024-06-25 23:09:04', 'ar'),
(53, 'ما هي الأماكن التي تحمل أسماء الشهداء تكريماً لهم؟\r\n', '\هناك العديد من المدارس والجامعات التي تحمل أسماء الشهداء تكريماً لتضحياتهم.\r\nتُسمى بعض الشوارع والساحات العامة بأسماء الشهداء لتخليد ذكراهم في المجتمع.\r\nيتم تسمية مراكز ثقافية ورياضية بأسماء الشهداء لتكريمهم والمساهمة في تعزيز التراث الثقافي.\r\nتُطلق أسماء الشهداء على المساجد والمباني الدينية تخليداً لتضحياتهم.\r\n', '2024-06-25 23:09:32', 'ar'),
(54, 'هل توجد نصب تذكارية للشهداء في فلسطين؟\r\n', '\نعم، توجد العديد من النصب التذكارية للشهداء في فلسطين تكريماً لتضحياتهم.\r\nتشمل هذه النصب تماثيل ونقوشًا تحمل أسماء الشهداء وتروي قصصهم.\r\nتوجد في بعض المدن ساحات عامة تضم نصباً تذكارية للشهداء تُستخدم لإقامة الفعاليات الوطنية والمناسبات التذكارية.\r\nتُنظم زيارات دورية لهذه النصب من قبل أفراد المجتمع والمدارس لتعزيز الوعي بتاريخ الشهداء وتضحياتهم.\\r\n', '2024-06-25 23:09:32', 'ar');

-- --------------------------------------------------------

--
-- Table structure for table `martyrs`
--

CREATE TABLE `martyrs` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `date_of_death` date DEFAULT NULL,
  `cause_of_death` text DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `description` text NOT NULL,
  `place_of_death` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `views` int(11) DEFAULT 0,
  `submitted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `martyrs`
--

INSERT INTO `martyrs` (`id`, `full_name`, `date_of_birth`, `date_of_death`, `cause_of_death`, `nationality`, `description`, `place_of_death`, `image_url`, `created_at`, `views`, `submitted_by`) VALUES
(7, 'tamer foqaha', '2000-06-03', '2024-05-04', 'battle', 'tulkarm', 'He was born in the city of Tulkarm, lived there, studied at Shweika Secondary School, studied at An-Najah University, joined the ranks of the Islamic Bloc there, joined the Al-Qassam Brigades, carried out 3 operations against the occupation forces, and was martyred in the village of Deir Al-Ghusoun in Tulkarm.', 'tulkarm', '1719096721188.jfif', '2024-06-22 22:52:01', 2, 5),
(8, 'Ahmed Yassin', '1936-01-01', '2004-03-22', 'Assassination', 'Gaza', 'Yassin was born in Ashkelon, in Mandatory Palestine in 1929 or 1936. His family fled or were expelled during the 1948 Palestine War to Gaza City. Yassin, a quadriplegic who was nearly blind, had been reliant on a wheelchair due to a sporting accident at the age of 12.\n\nAfter its founding, he served as the spiritual leader of Hamas, which is designated a terrorist organization by the US, the EU and other countries. The Israeli ocupation held him responsible for the killing of several Israeli civilians. In 2004, he was killed when an Israeli helicopter gunship fired a missile at him as he was being wheeled from Fajr prayer in Gaza City. The attack, which also killed both of his bodyguards and nine bystanders, was internationally condemned.200,000 Palestinians attended his funeral procession in Gaza', 'Gaza', '1719105418413.JPG', '2024-06-23 01:16:58', 0, 5),
(9, 'Yahya Ayyash ', '1966-03-06', '1996-01-05', 'Assassination', 'salfet', 'Ayyash was born in Rafat on 6 March 1966, the eldest of three brothers. As a child, he received an award from the Islamic Trust for his talent in memorizing the Quran.\n\nAs a boy, Ayyash\'s hobby was repairing radios and television sets. After graduating from high school in 1985, he entered Birzeit University in 1987. He received a Bachelor of Science degree in electrical engineering in 1991.\n\nDescribed as \"well educated, ambitious, and soft-spoken,\" Ayyash hailed from a relatively affluent family. He was married with one child. He planned to study for a master\'s degree in Jordan, but soon after being denied a student visa, he joined Hamas.', 'Gaza', '1719105929134.jpg', '2024-06-23 01:25:29', 0, 5),
(10, 'saleh alarory', '1966-08-19', '2024-01-02', 'Assassination', 'ramallah', 'A Palestinian political and military leader, former deputy head of the political bureau of the Islamic Resistance Movement “Hamas.” He contributed to the establishment of the “Al-Qassam Brigades,” the military wing of Hamas in the West Bank. He is considered the mastermind of arming the Al-Qassam Brigades. He was arrested and spent about 18 years in occupation prisons, then was deported from Palestine. One of the members of the negotiating team to complete the Wafa al-Ahrar deal, “the Shalit deal.” He was assassinated as a result of an Israeli air strike in Beirut. In the midst of its war on the Gaza Strip, its officials did not issue comments directly confirming Israel\'s responsibility for his assassination.', 'Lebanon-Beirut', '1719106165006.jpg', '2024-06-23 01:29:25', 0, 5),
(11, 'Salah Khalaf', '1933-01-01', '1991-01-14', 'Assassination', 'jaffa', 'A Palestinian political and military leader, former deputy head of the political bureau of the Islamic Resistance Movement “Hamas.” He contributed to the establishment of the “Al-Qassam Brigades,” the military wing of Hamas in the West Bank. He is considered the mastermind of arming the Al-Qassam Brigades. He was arrested and spent about 18 years in occupation prisons, then was deported from Palestine. One of the members of the negotiating team to complete the Wafa al-Ahrar deal, “the Shalit deal.” He was assassinated as a result of an Israeli air strike in Beirut. In the midst of its war on the Gaza Strip, its officials did not issue comments directly confirming Israel\'s responsibility for his assassination.', 'Tunisia', '1719106404354.png', '2024-06-23 01:33:24', 1, 5),
(12, 'Qais Adwan', '1977-01-01', '1991-01-14', 'Armed clash', 'Jenin', 'If Qais Adwan was known to his friends and loved ones as a committed, active man, with a strong personality, and able to reconcile the different colors of the Palestinian spectrum, then to his enemies he carried three characteristics that enabled him to be a very dangerous enemy for them, the first of which was his ability to make explosives. The second is his logistical imagination, which enabled him to plan precise attacks on the occupation soldiers and his state, and finally his superior combat capabilities.\n\nLike many martyrs, Qais Adwan’s perfume did not linger until after his martyrdom, when newspapers covered his responsibility for a number of martyrdom operations that deepened the enemy’s wounds and left more than 31 dead among its ranks.\n\nFrom the beginning, Qais Adwan was known for his steadfastness. He was nicknamed “Abu Jabal.” He was born in 1977 in the town of Siris, to a committed family. The warmth of his commitment pushed him into the embrace of the Muslim Brotherhood at an early stage in his life. He was one of the pioneers of the Grand Mosque in the city of Jenin, and he mastered it at the hands of... His memorizers memorized a large portion of the Holy Qur’an, and he perfected its intonation.\n\nIn 1995, Adwan completed his education in the scientific secondary branch with a high grade that qualified him to join the Faculty of Engineering at An-Najah National University, Department of Architecture.\n\nAt the beginning of his university career, Adwan was subjected to persecution and political arrest at the hands of the Palestinian Authority. He was detained in Al-Junaid Central Prison for more than six months. Following his release, he was arrested again by the Zionist occupation, as part of a single policy of joint security coordination and fighting the Islamic call and its activists.\n\nExcellence was essential to Adwan in his academic life and his union activity. He was one of the most active and generous students, which made him advance in the paths of the Islamic Bloc until he became a member of the student council in his third year, and president of its council in the last year before his graduation in 2000, after the excellence he demonstrated in His union performance, and the students’ love for him, as you always find students asking about Qais Adwan, due to his intense love for his fellow students, and his concern for their interests.\n\nWith the outbreak of the Al-Aqsa Intifada, Qais Adwan shone in the military ranks. He joined the Martyr Izz al-Din al-Qassam Brigades, and his first jihadist work was the “Wadi Ara” operation, which was carried out by the Mujahid Zaid al-Kilani.\n\nAdwan\'s abilities developed remarkably and in a short period of time, and he was able to master the manufacture of explosive belts quickly, and from his hands came the Qassami martyr Izz al-Din al-Masri to carry out the \"Sbarro Restaurant\" operation, in which more than 19 Zionists were killed.\n\nThe operations supervised by Engineer Qais Adwan varied, starting with martyrdom operations, passing through the operations of making Qassam missiles with his companion, the Qassam commander Saed Awad, to storming military sites, the most famous of which was the storming of the “Tayaseer” camp, which was carried out about two months ago by martyrdom fighters Saleh Kamil and Ahmed Ateeq from Jenin. To bombing Zionist patrols and vehicles on bypass roads.\n\nAdwan\'s jihad continued until the agents of the occupation and the henchmen of the authority were able to reach his place in the town of Tubas, where he took shelter with another Qassam group to prepare for joint jihad operations. On the morning of Friday, April 5, 2002, huge forces of the Zionist occupation surrounded them, and tanks and Apache helicopters joined them. The house where the Qassam cell met.\n\n The occupation army demanded that the Qassam martyrs surrender themselves, but to no avail, especially since they did not dare to storm the house, so they bombed it and shot it intensely, which led to the martyrdom of the Mujahid Qais Adwan and his brothers after six hours of an unequal battle led by Qais with his weapon, which he loved and loved. “Mother 16, while the enemy had aircraft, tanks, and heavy lethal weapons.', 'Tubas', '1719106850063.jpg', '2024-06-23 01:40:50', 0, 5),
(13, 'Ibrahim Al-Nabulsi', '2003-10-13', '2022-08-09', 'Armed clash', 'Nablus', 'He was a military commander and a prominent leader in the Al-Aqsa Martyrs Brigades during the year 2022, where he played a major role in a number of operations that targeted the Israeli occupation army until he became on Tel Aviv’s most wanted list. Al-Nabulsi was assassinated by Israeli forces when they fired a missile at the house in which he was holed up. He and a colleague of his died in his city of Nablus.', 'Nablus', '1719147530220.jpg', '2024-06-23 12:58:50', 0, 5);

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `photo_url` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `source` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `submitted_by` int(11) NOT NULL,
  `views` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `photo_url`, `name`, `description`, `source`, `type`, `submitted_by`, `views`, `created_at`) VALUES
(4, '1719177107527.jpg', 'Hezbollah stores a huge amount of weapons at Rafik Hariri Airport', 'Jerusalem - Ma\'an - The British newspaper \"The Telegraph\" claimed that Hezbollah is storing a huge amount of Iranian weapons, missiles and explosive materials at Beirut Airport (Rafik Hariri Airport). This was according to the testimonies of workers at the airport.\n\nAccording to the report, the stockpile apparently includes Iranian-made unguided artillery shells, short-range Fateh-110 missiles, mobile ballistic missiles and M-600 missiles with a range of more than 150 to 200 kilometers.\n\nAlso found at the airport were AT-14 Kornet missiles, laser-guided anti-armor guided missiles (ATGM), huge quantities of short-range Burkan ballistic missiles and the explosive material RDX, a toxic white dust also known as Cyclone or Hexagon.\n\n\nThe newspaper said that this discovery increases fears that Rafic Hariri Airport, which is only four kilometers from the city center, will turn into a central military target.', 'ma\'an', 'General', 5, 0, '2024-06-23 18:11:47'),
(5, '1719177331448.jpg', 'Half a million Israelis have left Israel so far', 'Jerusalem - Ma\'an - Hebrew Channel 12 said that about half a million Israelis left Israel in the first six months of the war.\n\nShe added that there will not be a \"complete victory,\" Hamas will not be destroyed, and Hezbollah will not disappear from the map\n\nShe said, \"Our families are disintegrating, our companies are collapsing, our reserve soldiers have their tongues cut off, and our \'regular soldiers\' are exhausted to the bone.\"\n\nShe said, \"Today, Hezbollah tried to attack Iron Dome, in addition to another security facility in the Karmiel area.\"\n\nShe said, \"Hezbollah knows the most sensitive targets in the north and knows them by heart.\"\n\n\nShe said, \"Canada suggests that Israelis immigrate to it due to the escalation in the north.\"', 'ma\'an', 'General', 5, 0, '2024-06-23 18:15:31'),
(6, '1719177982064.jpg', '9,345 arrests in the West Bank since October 7, 2023', 'The Prisoners\' and Ex-Prisoners\' Affairs Authority and the Prisoners\' Club announced today, Sunday, that the number of arrests by the Israeli occupation forces after October 7, 2023 has increased to about 9,345 citizens from the West Bank and occupied Jerusalem. The two bodies said, \"The occupation arrested at least 20 citizens from the West Bank from yesterday until today, including children, a high school student, and former prisoners.\" She pointed out that the statistics include those who were arrested from homes, through military checkpoints, or were forced to surrender themselves under pressure, and those who were held hostage. It was reported that the arrests were concentrated in the Hebron Governorate, while the rest were distributed among the governorates of Nablus, Ramallah, Qalqilya, Jericho and Tubas. The two bodies explained that the arrests were accompanied by abuse, severe beatings, and threats against the detainees and their families, in addition to widespread sabotage and destruction of citizens’ homes.', 'shehabnews', 'General', 5, 0, '2024-06-23 18:26:22');

-- --------------------------------------------------------

--
-- Table structure for table `palestinian_villages`
--

CREATE TABLE `palestinian_villages` (
  `id` int(11) NOT NULL,
  `village_name` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `historical_context` text DEFAULT NULL,
  `current_status` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `submitted_by` int(11) DEFAULT NULL,
  `views` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `palestinian_villages`
--

INSERT INTO `palestinian_villages` (`id`, `village_name`, `city`, `historical_context`, `current_status`, `image_url`, `created_at`, `submitted_by`, `views`) VALUES
(1, 'ainhoud', 'حيفا', 'قرية فلسطينية مهجرة', 'محتلة', '1717570099404.jpeg', '2024-06-19 19:30:02', 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `prisoners`
--

CREATE TABLE `prisoners` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `date_of_arrest` date DEFAULT NULL,
  `place_of_birth` varchar(255) DEFAULT NULL,
  `life_story` text DEFAULT NULL,
  `views` int(11) DEFAULT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prisoners`
--

INSERT INTO `prisoners` (`id`, `name`, `date_of_birth`, `date_of_arrest`, `place_of_birth`, `life_story`, `views`, `photo_url`, `submitted_by`, `created_at`) VALUES
(1002, 'Abdullah Barghouti', '1972-01-01', '2003-03-05', 'Kuwait', 'Abdullah Ghalib Abdullah Al-Barghouti (Abu Osama); (Born in 1972 AD, Kuwait) is a Palestinian resistance fighter. He is an engineer and former commander of the Izz al-Din al-Qassam Brigades in the West Bank. He is a prisoner in Israeli prisons. He is currently serving one of the greatest sentences in history with life imprisonment 67 times, in addition to five thousand two hundred (5,200) years. For his responsibility for the killing of 67 Israelis in a series of operations carried out between 2000 and 2003 AD. He is considered Yahya Ayyash\'s successor in managing bombing operations. His origins come from the town of Beit Rima in Palestine.', 0, '1719194154111.jpg', 5, '2024-06-24 01:55:54'),
(1003, 'Marwan Barghouti', '1959-06-06', '2002-04-01', 'Ramallah', 'Marwan Barghouti (June 6, 1958) is a prominent Palestinian politician, and one of the Palestinian leadership figures. He was arrested several times at the hands of the Israeli occupation forces, and in 1986 he was deported from the homeland. He returned in 1994 as part of the Oslo Accords, where he was elected as deputy to the martyr leader Faisal al-Husseini, and secretary. The Fatah movement in the West Bank. In 1996, he was elected a member of the Fatah Legislative Council, and he was its youngest member. He played a prominent role during the second Palestinian Intifada, and as a result, the Israeli authorities arrested him in 2002. He is considered the first member of the Fatah Movement’s Central Committee. The first Palestinian MP to be arrested by the occupation authorities and sentenced to life imprisonment.', 0, '1719194394734.jpg', 5, '2024-06-24 01:59:54');

-- --------------------------------------------------------

--
-- Table structure for table `review_martyrs`
--

CREATE TABLE `review_martyrs` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date_of_birth` date NOT NULL,
  `date_of_death` date NOT NULL,
  `description` text DEFAULT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `cause_of_death` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `place_of_death` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review_martyrs`
--

INSERT INTO `review_martyrs` (`id`, `name`, `date_of_birth`, `date_of_death`, `description`, `photo_url`, `submitted_by`, `cause_of_death`, `nationality`, `place_of_death`) VALUES
(1, 'yahya ayash', '0000-00-00', '0000-00-00', NULL, '1715689973291.webp', 5, 'battle', 'nablus', 'nablus'),
(2, 'yahya ayash', '0000-00-00', '0000-00-00', NULL, '1717465032481.webp', 5, 'battle', 'nablus', 'nablus'),
(5, 'yahya ayash', '0000-00-00', '0000-00-00', NULL, '1717480153492.webp', 5, 'battle', 'nablus', 'nablus'),
(6, 'yahya ayash', '0000-00-00', '0000-00-00', NULL, '1717480202823.webp', 5, 'battle', 'nablus', 'nablus'),
(7, 'yahya ayash', '0000-00-00', '0000-00-00', NULL, '1718288064507.jpeg', 5, 'battle', 'nablus', 'nablus'),
(8, 'yahya ayash', '0000-00-00', '0000-00-00', NULL, '1718818755075.jpeg', 5, 'battle', 'nablus', 'nablus');

-- --------------------------------------------------------

--
-- Table structure for table `review_news`
--

CREATE TABLE `review_news` (
  `id` int(11) NOT NULL,
  `photo_url` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `source` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `views` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review_news`
--

INSERT INTO `review_news` (`id`, `photo_url`, `name`, `description`, `source`, `type`, `submitted_by`, `views`) VALUES
(1, '1717481721608.webp', 'www', 'asdasd', 'aljazera', 'art', 5, 0),
(2, '1717482020263.webp', 'www', 'asdasd', 'aljazera', 'art', 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `review_palestinian_villages`
--

CREATE TABLE `review_palestinian_villages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `village_name` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `historical_context` text DEFAULT NULL,
  `current_status` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `submitted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review_prisoners`
--

CREATE TABLE `review_prisoners` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `date_of_arrest` date DEFAULT NULL,
  `place_of_birth` varchar(255) DEFAULT NULL,
  `life_story` text DEFAULT NULL,
  `views` int(11) DEFAULT 0,
  `photo_url` varchar(255) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `review_videos`
--

CREATE TABLE `review_videos` (
  `id` int(11) NOT NULL,
  `video_path` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `location` varchar(255) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `verified` enum('yes','no') DEFAULT 'no'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `phone_number`, `verified`) VALUES
(5, 'yazanaboalhijaco@gmail.com', '$2b$10$LfEUw6Mp1daX1rCHbWAWTOiULo0/QCY1UzF2Egu9DTX2VPaa5wUXS', 'yazan abu alhayja', '1234567890', 'yes'),
(22, 's11927181@stu.najah.edu', '$2b$10$QiVEeJUDEWLZUSFrKK0zee8UaM6jNtJxw2q.PJpJdDolwl4B8PxgW', 'yazan abu alhayja', '1234567890', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `videos`
--

CREATE TABLE `videos` (
  `id` int(11) NOT NULL,
  `video_path` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `location` varchar(255) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `views` int(11) DEFAULT 0,
  `created_at` timestamp(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `videos`
--

INSERT INTO `videos` (`id`, `video_path`, `description`, `upload_date`, `location`, `submitted_by`, `views`, `created_at`) VALUES
(1, '1716306081701-gaza.mp4', 'قصيدة لتميم gaza', '2024-06-19 19:29:12', 'غزة', 5, 0, '0000-00-00 00:00:00.000000'),
(2, '1718893635535.mp4', 'قصيدة لتميم البرغوثي', '2024-06-20 14:27:15', 'غزة', 5, 0, '0000-00-00 00:00:00.000000'),
(3, '1718893727793.mp4', 'قصيدة لتميم البرغوثي', '2024-06-20 14:28:47', 'غزة', 5, 0, '0000-00-00 00:00:00.000000'),
(5, '1719192762433.MP4', 'Raising the call to prayer over homes destroyed by the occupation’s aggression in Khan Yunis, south of the Gaza Strip.', '2024-06-24 01:32:42', 'Gaza', 5, 0, '2024-06-24 01:32:43.000000'),
(6, '1719193352538.mp4', 'The occupation forces carried out an assassination operation in Qalqilya', '2024-06-24 01:42:32', 'Qalqilya', 5, 0, '2024-06-24 01:42:32.000000'),
(7, '1719193525419.MP4', 'Yabna and Al-Shaboura camps in Rafah, which are subjected to a “limited” military operation by the Zionist occupation.', '2024-06-24 01:45:25', 'Gaza', 5, 0, '2024-06-24 01:45:25.000000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `martyrs`
--
ALTER TABLE `martyrs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submitted_by` (`submitted_by`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submitted_by` (`submitted_by`);

--
-- Indexes for table `palestinian_villages`
--
ALTER TABLE `palestinian_villages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submitted_by` (`submitted_by`);

--
-- Indexes for table `prisoners`
--
ALTER TABLE `prisoners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submitted_by` (`submitted_by`);

--
-- Indexes for table `review_martyrs`
--
ALTER TABLE `review_martyrs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submitted_by` (`submitted_by`);

--
-- Indexes for table `review_news`
--
ALTER TABLE `review_news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submitted_by` (`submitted_by`);

--
-- Indexes for table `review_palestinian_villages`
--
ALTER TABLE `review_palestinian_villages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submitted_by` (`submitted_by`);

--
-- Indexes for table `review_prisoners`
--
ALTER TABLE `review_prisoners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submitted_by` (`submitted_by`);

--
-- Indexes for table `review_videos`
--
ALTER TABLE `review_videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submitted_by` (`submitted_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submitted_by` (`submitted_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `martyrs`
--
ALTER TABLE `martyrs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `palestinian_villages`
--
ALTER TABLE `palestinian_villages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `prisoners`
--
ALTER TABLE `prisoners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1004;

--
-- AUTO_INCREMENT for table `review_martyrs`
--
ALTER TABLE `review_martyrs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `review_news`
--
ALTER TABLE `review_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `review_palestinian_villages`
--
ALTER TABLE `review_palestinian_villages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `review_prisoners`
--
ALTER TABLE `review_prisoners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `review_videos`
--
ALTER TABLE `review_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `videos`
--
ALTER TABLE `videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `martyrs`
--
ALTER TABLE `martyrs`
  ADD CONSTRAINT `martyrs_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `news_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `palestinian_villages`
--
ALTER TABLE `palestinian_villages`
  ADD CONSTRAINT `palestinian_villages_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `prisoners`
--
ALTER TABLE `prisoners`
  ADD CONSTRAINT `prisoners_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `review_martyrs`
--
ALTER TABLE `review_martyrs`
  ADD CONSTRAINT `review_martyrs_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `review_news`
--
ALTER TABLE `review_news`
  ADD CONSTRAINT `review_news_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `review_palestinian_villages`
--
ALTER TABLE `review_palestinian_villages`
  ADD CONSTRAINT `review_palestinian_villages_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `review_prisoners`
--
ALTER TABLE `review_prisoners`
  ADD CONSTRAINT `review_prisoners_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `review_videos`
--
ALTER TABLE `review_videos`
  ADD CONSTRAINT `review_videos_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
