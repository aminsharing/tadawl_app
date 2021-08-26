import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tadawl_app/main.dart';
import 'package:tadawl_app/provider/locale_provider.dart';

class Item {
  Item({this.expandedValue, this.headerValue, this.isExpanded = false});
  String expandedValue;
  String headerValue;
  bool isExpanded;
}

Item item1 = Item(
    headerValue: '1- قبول الاتفاقية',
    expandedValue:
        'أنت تتعهد بقبول الشروط والأحكام الواردة في هذه الاتفاقية ("الاتفاقية") فيما يتعلق بالتطبيق تشكل هذه الاتفاقية كامل الاتفاق بيننا وبينك وتلغي كافة الاتفاقات السابقة والضمانات وأي اتفاق سابق فيما يتعلق بالتطبيق أو المحتوى أو الخدمات المزودة من قبل التطبيق أو من خلاله وموضوع هذه الاتفاقية. يمكن تعديل هذه الاتفاقية من وقت لآخر من قبلنا دون إشعار مسبق إليك. سيتم نشر أحدث نسخة من هذه الاتفاقية عبر التطبيق وعليك أن تتطلع عليها قبل استخدامك للتطبيق');
Item item2 = Item(
    headerValue: '2- حقوق النشر',
    expandedValue:
        'إن المحتوى والتنظيم والتصميم والتجميع والترجمة الممغنطة والحوارات الرقمية وجميع المسائل الأخرى المتعلقة بتطبيق تداول العقاري (ان وجدت) محمية بموجب قوانين حقوق المؤلف والعلامات التجارية وحقوق الملكية الأخرى السارية المفعول إن أي نسخ أو توزيع أو نشر من قبلك لأي من الأشياء المذكورة أعلاه لأي جزء من التطبيق، باستثناء ما هو مصرح به حسب البند رابعا أدناه يعتبر محظورا. لا تمتلك أي حقوق ملكية لأي محتوى أو وثيقة أو مادة معروضة على التطبيق كما لا يعتبر نشر المعلومات أو المواد عبر التطبيق تنازلا عن حقوق التطبيق لأي حق يتعلق بهذه المعلومات أو المواد');
Item item3 = Item(
    headerValue: '3- العلامات التجارية',
    expandedValue:
        'إن تطبيق تداول العقاري وغيرها من العلامات التجارية التي قد تُضاف هي إما علامات تجارية أو علامات مسجلة ومملوكة من قبل المؤسسة المالكة للتطبيق');
Item item4 = Item(
    headerValue: '4- الحق المحدود بالاستخدام',
    expandedValue:
        ': أن استعراض أو طباعة أو تحميل أي محتوى أو رسم أو نموذج من التطبيق يخولك فقط بترخيص محدود وغير حصري بالاستعمال وحصرياً لاستعمالك الشخصي والاستعمال العادل لأغراض تعليمية غير ربحية وليس لإعادة النشر أو التوزيع أو الإحالة أو الترخيص الفرعي أو البيع أو تحضير الأعمال الاشتقاقية أو أي استعمال آخر. لا يجوز إعادة إنتاج أي جزء من أي محتوى أو نموذج أو وثيقة بأي شكل من الأشكال أو تضمينه لأي نظام استرجاع معلومات إلكتروني أو ميكانيكي باستثناء الاستعمال الشخصي (لغير غايات البيع أو إعادة التوزيع)');
Item item5 = Item(
    headerValue: '5- التحرير والحذف والتعديل',
    expandedValue:
        'نحتفظ بحقنا وبإرادتنا المنفردة بتعديل أو حذف أي وثيقة أو معلومة أو أي محتوى آخر ظاهر على التطبيق');
Item item6 = Item(
    headerValue: '6- الإقرار بالمسؤولية',
    expandedValue:
        'أنت تقر بمسؤوليتك القانونية الكاملة والمنفردة عن دقة أي مواد و/أو معلومات و/أو بيانات و/أو صور تقوم بتحميلها و/أو نشرها على التطبيق كما أنك تقر بأن تلك المواد و/أو المعلومات و/أو البيانات و/أو الصور لا تخل أو تنتهك حقوق ملكية أطراف ثالثة أو حقوق الغير وكذلك انت تقر بعدم مسؤوليتنا عن أن المقال أصلي أو منقول أو منسوخ عن أي شخص ثالث أو أن المقال تم نسبته الى غير كاتبه وتتحمل كامل المسؤولية اتجاهنا واتجاه أي أطراف ثالثة نتيجة عدم التزامك بهذا البند وان موافقتنا على نشر أي مواد و/أو معلومات و/أو بيانات و/أو صور تقوم بتحميلها و/أو نشرها على التطبيق لا تعني بأي شكل من الأشكال تحملنا أي مسؤولية ناشئة عنها');
Item item7 = Item(
    headerValue: '7- الحذف والتعويض',
    expandedValue:
        ' \n يحق لنا عدم نشر و/أو حذف أي مادة أو تعليق أو صورة لا تتوافق مع شروط هذه الاتفاقية أو لا يتناسب مع سياسة التطبيق كما يحق لنا الغاء التسجيل (ان وجد) كما أنك توافق على تعويضنا والمدافعة عنا وإخلاء مسؤوليتنا وشركائنا ومحامينا وموظفينا وحلفائنا (يشار إليهم مجتمعين "الأطراف المتآلفة") من أي مسؤولية أو خسارة أو ادعاء أو نفقات بما في ذلك أتعاب المحاماة المعقولة، فيما يتعلق بإخلالك لنصوص هذه الاتفاقية أو استعمالك للتطبيق، إن كنت تعتقد بأنه تم التعدي على حق من حقوقك فعليك التواصل لرفع شكوى على الايميل التالي:'
        'info@tadawl.com.sa \n '
        ' \n وتقديم ما يثبت أحقيتك في الإعلان المنشور');
Item item8 = Item(
    headerValue: '8- عدم القابلية للتحويل',
    expandedValue:
        ': أن حقك باستعمال التطبيق وأي كلمة مرور تمنح لك للحصول على المعلومات أو الوثائق غير قابل للتحويل');
Item item9 = Item(
    headerValue: '9- نفي المسؤولية وحدودها',
    expandedValue:
        'ان المعلومات المقدمة من خلال التطبيق تقدم "كما هي" وكل الضمانات سواء صريحة أو ضمنية تعتبر ملغاة (بما في ذلك دون حصر، التنازل عن أي ضمانات ضمنية تتعلق بالملائمة لغرض محدد). قد تحتوي المعلومات والخدمات على الديدان الالكترونية أو الأخطاء أو المشاكل أو المسائل الأخرى التي قد تحد من فعاليتها. لا نتحمل نحن أو الأطراف المتآلفة أي مسؤولية من أي نوع نتيجة استخدامك لأي من المعلومات أو الخدمات. على وجه الخصوص وليس على سبيل الحصر، لا نتحمل نحن أو الأطراف المتآلفة أي مسؤولية ناتجة عن أي ضرر مباشر أو غير مباشر أو عارض أو تبعي (بما في ذلك الأضرار الناجمة عن خسارة العمل أو الربح الفائت أو التقاضي أو ما شابه ذلك)، سواء كانت نتيجة الإخلال بالعقد أو الإخلال بالضمانات أو الضرر (بما في ذلك الإهمال والتقصير) وغيرها، حتى إذا كان لدينا علم بإمكانية حصول الضرر. إن إنكار المسؤولية عن الضرر المنصوص عليه أعلاه عنصر رئيسي في الاتفاق ما بيننا. لن يتم تقديم الخدمة أو المعلومات دون التقيد بحدود المسؤولية المشار إليها أعلاه. لا تشكل أي معلومة سواء حصلت عليها بشكل خطي أو شفوي عبر التطبيق أي ضمانة أو كفالة أو تعهد ما لم يكن منصوص عليها صراحة في هذه الاتفاقية. إن أي مسؤولية عن أي ضرر ناتج عن الفيروسات المحتوى في الملف الالكتروني الذي يتضمن النموذج أو الوثيقة تعتبر لا غيه. لن نكون مسئولين تجاهك عن أي ضرر عارض أو خاص أو تابع من أي نوع نتيجة استخدامك أو عدم قدرتك على استخدام التطبيق، استخدام التطبيق أو المحتويات يكون على مسؤوليتك الخاصة. قد تتضمن المحتويات الموجودة في هذا التطبيق أخطاءً فنية وأخطاءً مطبعية، بما في ذلك على سبيل المثال لا الحصر، عدم الدقة فيما يتعلق بالأسعار أو الرسوم أو مدى التوافر المطبق على معاملتك. لا تتحمل المؤسسة مالكة التطبيق ولا مانحو الترخيص التابعين لها ولا شركاؤها (ان وجدت) أي مسؤولية أو مسؤولية قانونية عن مثل هذه الأخطاء أو حالات عدم الدقة أو الإغفال، كما لا تتحمل أي التزام تجاه أي معلومات عقارية تُقدم من قبل المعلنين في التطبيق التي تتأثر بهذه الأخطاء أو حالات عدم الدقة أو الإغفالات. قد تقوم إدارة التطبيق بإجراء تغييرات و/ أو تصحيحات، و/ أو إلغاءات، و/ أو تحسينات في أي وقت، بما في ذلك بعد تأكيد المعاملة');
Item item10 = Item(
    headerValue: '10- استعمال المعلومات',
    expandedValue:
        'نحتفظ بحقنا وأنت تخولنا بأن نستعمل ونحيل كافة المعلومات المتعلقة باستخدام التطبيق من قبلك وكافة المعلومات التي تزودنا بها بأي طريقة تتلاءم مع سياسة الخصوصية');
Item item11 = Item(
    headerValue: '11- خدمات الأطراف الأخرى',
    expandedValue:
        'إننا قد نسمح بالوصول إلى أو الإعلان عن مواقع تجارية لأطراف أخرى ("التجار") والتي يمكنك من خلالها شراء عقار أو الحصول على خدمات معينة. تقر بموجب هذه الاتفاقية إننا لا يمكننا إدارة أو التحكم بالخدمات المعروضة من قبل التجار أو العقار أو السلعة مهما كانت. وان التجار هم المسئولين عن كافة خصائص معالجة الطلبات وتلبيتها وإصدار الفواتير وخدمة العملاء التي تخصهم. أنت تقرّ بأننا لسنا من يدير أو يتحكم بالخدمات المقدمة من قبل التجار المعلنين بالتطبيق كما تقرّ بأن استعمالك لمواقع التجار خارج التطبيق هو على مسؤوليتك الشخصية دون أي ضمانات من أي نوع من قبلنا سواء اكانت ضمانات صريحة أو ضمنية أو غيرها بما في ذلك أي ضمانات تتعلق بالملكية أو الملائمة لغرض معين أو الصلاحية التجارية أو عدم الإخلال. لن نكون مسئولين عن أي ضرر ناجم عن الصفقة التي تعقدها مع التجار تحت أي ظرف من الظروف أو عن أي معلومة تظهر على موقع التاجر (المعلن) أو أي موقع آخر مرتبط بموقعنا (ان وجد)');
Item item12 = Item(
    headerValue: '12- سياسة الخصوصية',
    expandedValue:
        'أن سياستنا للخصوصية، كما قد يتم تعديلها من وقت لآخر، تشكل جزءا لا يتجزأ من هذه الاتفاقية، عند استخدامك لهذا التطبيق، ستكون مسؤولاً عن الحفاظ على سرية حسابك وكلمة المرور، أنت توافق على قبول المسؤولية عن جميع الأنشطة العقارية بالبيع أو الايجار التي تُنفَّذ عبر حسابك أو كلمة المرور الخاصة بك. تحتفظ إدارة التطبيق بالحق في رفض الخدمة أو إغلاق الحسابات أو إزالة المحتويات أو تعديلها أو إلغاء الطلبات والأوامر استنادًا إلى تقديرها المطلق');
Item item13 = Item(
    headerValue: '13- الروابط إلى مواقع أخرى',
    expandedValue:
        'يحتوي التطبيق على روابط أخرى لكننا غير مسئولين عن دقة محتوى أي موقع مرتبط أو عن الآراء الواردة في مثل هذه المواقع كما أننا لا نقوم بتفحص أو التحقق من دقة واكتمال المعلومات الواردة في هذه المواقع. أن تضمين رابط أي موقع على موقعنا لا يعني موافقتنا أو مصادقتنا على ما ورد فيه. إن قمت بترك موقعنا والدخول في أي موقع مرتبط فإنك تقوم بذلك على مسئوليتك الشخصية');
Item item14 = Item(
    headerValue: '14- حقوق النشر ووكلاء حقوق النشر',
    expandedValue:
        'إننا نحترم الملكية الفكرية للآخرين ونطلب منك ذلك أيضا. أن كنت تعتقد بأن عملا يعود لك قد تم نسخه بطريقة قد تشكل انتهاكا لحقوق النشر، يرجى منك تزويدنا بالمعلومات التالية: أ‌. توقيع الكتروني أو فعلي الشخص المخول التصرف بالنيابة عن مالك حق النشر الأصلي فيما يتعلق بفوائد حق النشر. بوصف العمل الذي تدعي بأنه قد تعرض للانتهاك وتصف وتشير للجزء الذي تدعي بأنه مخل ومكانه على التطبيق. وافادتنا بعنوانك ورقم هاتفك وعنوان بريدك الالكتروني، ان التصريح من قبلك يفيد بان لديك اعتقاد حسن النية بان الاستعمال موضوع الادعاء غير مصرح به من قبل مالك الحق أو وكيله أو القانون. وأخيراً ان التصريح من قبلك تحت طائلة عقوبة شهادة الزور بأن المعلومات الواردة في الإشعار المبين أعلاه دقيقة وأنك المالك لحق النشر أو المفوض بالنيابة عن المالك');
Item item15 = Item(
    headerValue: '15- المعلومات والمنشورات العقارية',
    expandedValue:
        'يحتوي التطبيق على معلومات ومنشورات عقارية. وحيث أننا نعتقد بصحة هذه المعلومات وقت نشرها وتحضيره إلا أننا ننكر أي مسؤولية أو التزام بتحديث هذه المعلومات أو أي نشرة أو اعلان عقاري. يجب ألا يتم الاعتماد على المعلومات الواردة عن شركات أخرى في المنشورات العقارية وألا يتم التعامل معها على انها معلومات مصادق عليها من قبلنا');
Item item16 = Item(
    headerValue: '16- نصوص عامة',
    expandedValue:
        'تعتبر هذه الاتفاقية وكأنها تم تنفيذها وتحريرها في المملكة العربية السعودية ويجب أن تخضع وتفسر حسب القوانين المملكة (دون اعتبار لنصوص وقواعد تنازع القوانين). أن أي إجراء قانوني من قبلك فيما يتعلق بالتطبيق (و/أو أي معلومة أو خدمة مرتبطة به) يجب القيام به خلال سنة (1) واحدة من نشوء سبب الإجراء القانوني وإما أن تسقط حقك للأبد. إن جميع الإجراءات تخضع للتقييد الوارد في البندين 8 و10 أعلاه. تفسر لغة هذه الاتفاقية حسب معناها المنطقي والعادل دون التحيز لأي من الأطراف. تختص محاكم المملكة بالمدينة المتواجد بها التطبيق الرئيسي لإدارة التطبيق (الرياض) حصرياً بنظر أي نزاع قد ينشب بين الأطراف نتيجة هذه الاتفاقية. تقرّ صراحة بالاختصاص الحصري للمحاكم المذكورة أعلاه وتوافق على صحة إجراءات التبليغ خارج حدود الدولة. إذا تم الحكم بأن أي جزء من هذه الاتفاقية غير نافذ أو غير قابل للتنفيذ فإن ذلك الجزء يجب أن يفسر بما يتفق مع القوانين السارية على أن تتمتع باقي نصوص الاتفاقية بكامل الأثر القانوني والفعالية. إذا ورد في التطبيق أي شيء قد يخالف أو يتعارض مع نصوص هذه الاتفاقية فإن نصوص الاتفاقية تتمتع بالأولوية في التطبيق. إن إخفاقنا أو عدم ممارستنا لأي بند من بنود هذه الاتفاقية يجب ألا يعتبر تنازلا عن ذلك النص أو عن الحق بتنفيذ ذلك النص وتقع على مسؤوليتك الشخصية (العميل المستخدم للتطبيق) التقيد بجميع شروطنا وأحكامنا الخاصة والتي تتضمن الدفع الكامل وفي الوقت المناسب لجميع المبالغ المستحقة مع الامتثال لجميع القواعد المتعلقة حول العمولة والرسوم، تقدم مؤسسة التداول العقاري للتسويق الإلكتروني خدمة تمكين المستخدم من عرض سلعته وفق سياسة الاستخدام المتفق عليها ولا نقدم أي ضمانات ولا نتحمل أي مسؤولية في حالة عدم التزام المستخدم (التاجر المعلن) بسياسة استخدام التطبيق ولا نتحمل المسؤولية عن أي مخاطرة أو أضرار أو تبعات أو خسائر تقع على البائع أو المشتري أو أي طرف آخر وعلى من لحق به الضرر إبلاغنا بذلك من خلال رابط اتصل بنا وشرح الضرر الواقع عليه وستقوم المؤسسة باتخاذ الإجراء حسب نوع الواقعة دون أي مسؤولية إن استخدامك للتطبيق يعني أنك تخولنا في حفظ بياناتك التي قمت بإدخالها بخوادم المؤسسة ولنا حق الاطلاع عليها ومراجعتها كما أنك توافق على أحقيتنا في مراقبة الرسائل الخاصة عند الحاجة لضمان خلوها من مخالفات اتفاقية الاستخدام ولنا حق حذف الإعلان والتصرف بالصور المرفقة وحذف التعليقات عند الحاجة لذلك وتعتبر تعاميم وقرارات وتوجيهات إدارة ومشرفي التطبيق ملزمة للغير بعد إيصالها له عبر الرسائل الخاصة بالتطبيق أو الجوال أو البريد الإلكتروني أو عبر نظام الإشعارات ، وعليه الالتزام بها والعمل بموجبها، تعد جميع العروض الايجارية أو العروض الترويجية العقارية التي يتم الإعلان عنها على هذا التطبيق أو أي منها لاغيةً فور حظرها، وتخضع لنشر أي قواعد رسمية تنظم تلك العروض أو العروض الترويجية');
Item item17 = Item(
    headerValue: '17- شروط الإعلان في التطبيق',
    expandedValue:
        'يجب أن يكون الإعلان لبيع أو تأجير أو تقبيل عقار فقط حسب موضوع التطبيق وأهدافه، يتحمل العميل المعلن بشخصه أو عبر من أنابه عن صحة كافة المعلومات المدخله بالتطبيق، يجب أن يكون الإعلان مكتمل دون أي غش أو تدليس وبه التفاصيل اللازمة لنفي ذلك وأن يكون في القسم الصحيح من التطبيق، يحق لإدارة التطبيق حذف أي إعلان من دون ذكر سبب الحذف إذا كان الاعلان غرضه مشبوه أو به علامات قد تدل على ذلك ويخضع ذلك لتقدير ادارة التطبيق، يقر العميل (المعلن) بأن الصور المضافة في الإعلان الخاص بحسابه لنفس العقار المعلن عنه ويلتزم بتحديث الصور اذا طرأ على العقار أي شيء أو تغيير، يتعهد المعلن بحذف الإعلان في حالة الانتهاء من الغاية الذي وضع لأجلها الإعلان بعد دفع ما يترب على ذلك من رسوم للتطبيق،يتحمل المعلن بشكل منفرد عن أي تلاعب ناتج عن مُخالفة سياسية التطبيق أو مُخالفة أي نظام من أنظمة المملكة العربية السعودية المعنية بالخصوص فيما يتعلق بأسعار العقار سواء في البيع او الشراء وإلحاق الضرر بالمستخدمين الآخرين والحرص على أن يكون السعر مطابق للواقع تماما');
Item item18 = Item(
    headerValue: '18- سياسة الاسترجاع',
    expandedValue:
        'تنص مؤسسة تطبيق تداول التجارية ان سياسة الاسترجاع تتضمن العمولات والاشتراك السنوي: يحق للمستخدم طلب استرجاع العمولة المدفوعة خلال (10) أيام من تاريخ الدفع، ويستثنى من ذلك استرجاع مبلغ الاشتراك السنوي، نقل الاشتراك: المدة المسموحة لنقل الاشتراك لعضو آخر مدة أقصاها (5) أيام من تاريخ الدفع، الإعلان المميز: لا يتم استرجاع قيمة الإعلان المميز في الويب والتطبيق، ترقية الباقة: لا يتم استرجاع قيمة ترقية الباقة، المبالغ الزائدة: يتم استرجاع المبالغ الزائدة عن الاشتراك والعمولة خلال مدة أقصاها (5) أيام من تاريخ الدفع، لطلب الاسترجاع يجب على المستخدم التواصل مع الدعم الفني من خلال ايقونة " اتصل بنا" وتزويدهم بـ تاريخ الحوالة، البنك المحول عليه، رقم الحساب وتستغرق مدة استرجاع المبلغ الى حسابك مدة أقصاها (5) أيام عمل، وفي حال أي تأخير في إعادة المبلغ يتوجب على المستخدم المتابعة مع البنك مباشرة في حال التحويل من بنك لبنك آخر يتم خصم رسوم البنك');
Item item19 = Item(
    headerValue: '19- الأهلية لاستخدام التطبيق',
    expandedValue:
        'لا يمكن لك استخدام هذا التطبيق ما لم تكن قد بلغت سن 18 عامًا على الأقل وأصبح بمقدورك إبرام عقود ملزمة قانونًا (لا يُتاح للقُصّر استخدام التطبيق). باستخدامك هذا التطبيق، فإنك تقر ببلوغك 18 عامًا على الأقل. جميع المعلومات والمواد الواردة في هذا التطبيق مُخصَّصة لأغراض التجارة العقارية فقط. قد يتم تقديم بعض المعلومات والمواد الواردة في هذا التطبيق من قِبل أصحاب الامتياز الذين يتمتعون بالصلاحية للتحكم في السياسات والإجراءات المُطبقة في التطبيق');
Item item20 = Item(
    headerValue: '20- تقديم الأفكار',
    expandedValue:
        'يسر إدارة التطبيق الإصغاء لمستخدميها وترحب كذلك بتعليقاتكم فيما يتعلق بالتطبيق وخدماتنا العقارية. غير أن سياسة مؤسستنا لا تسمح لنا، للأسف، بقبول أو أخذ أفكار أو مقترحات أو مواد إبداعية بعين الاعتبار فيما عدا تلك التي نطلبها على وجه الخصوص. إذ أن طاقم عملنا ومستشارينا أصحاب الموهبة والخبرة قد يكونون في طور العمل على الأفكار نفسها أو أفكار مماثلة لها. وعليه فإننا نرجو تفهمكم أن الغرض من هذه السياسة هو تجنب احتمالية وقوع حالات سوء فهم مستقبلية قد تبدو فيها مشاريعنا، التي طورها أفراد طاقم عملنا و/ أو مستشارونا المحترفون، بالنسبة للآخرين مشابهةً لأعمالهم الإبداعية الخاصة. يُرجى عدم إرسال أي مواد إبداعية أصلية من أي نوع ما لم نطلبها. إذا أرسلت، بناءً على طلبنا، مقترحات خاصة محددة أو أرسلت، خلافًا لطلبنا، مقترحات أو أفكار أو ملاحظات أو مخططات أو تصورات إبداعية أو معلومات أخرى (يُشار إليها جميعها باسم "المقترحات المقدَّمة")، تُمنح تلقائيًا عندئذٍ ترخيصًا دائمًا غير مقيد بحقوق ملكية، وغير قابل للإلغاء، وغير حصري شاملًا أي مكان في العالم يجيز لها استخدام تلك المقترحات المقدَّمة. ويشمل استخدام هذه المقترحات المقدَّمة إعادة نسخ المقترحات المقدَّمة وإنشاء أعمال مشتقة منها وتعديلها ونشرها وتحريرها وترجمتها وتوزيعها وعرضها بأي أدوات أو وسائط أو أي شكل أو صيغة أو منتدى معروف في الوقت الراهن أو قيد التطوير في المستقبل، ولكن هذا لا يشكل قائمة شاملة. يجوز لإدارة التطبيق التعامل مع هذه المقترحات المقدمة على أنها معلومات غير سرية، ولن تتحمل كذلك أية مسؤولية قانونية عن استخدام أي مقترحات مقدَّمة أو الإفصاح عنها. تتمتع المؤسسة مالكة التطبيق، دون تقييدٍ لما سبق، بالحق في استخدام تلك المقترحات المقدَّمة دون أي شرط أو قيد لأي غرض سواء أكان تجاريًا أو غير ذلك دون تعويض أو التزام تجاه مقدم تلك المقترحات المقدَّمة');

List<Item> generatedItems() {
  var items = <Item>[
    item1,
    item2,
    item3,
    item4,
    item5,
    item6,
    item7,
    item8,
    item9,
    item10,
    item11,
    item12,
    item13,
    item14,
    item15,
    item16,
    item17,
    item18,
    item19,
    item20
  ];
  return items;
}

class GeneralProvider extends ChangeNotifier {
  GeneralProvider(){
    print('init GeneralProvider');
  }

  @override
  void dispose() {
    print('dispose GeneralProvider');
    super.dispose();
  }

  String _name, _mobile, _title, _details;

  final List<Item> _data = generatedItems();

  void filterPhone(var Phone) {
    if (Phone.toString().length == 10 && Phone.toString().startsWith('05')) {
      _mobile = Phone.toString().replaceFirst('0', '966');
    } else if (Phone.toString().startsWith('5')) {
      _mobile = Phone.toString().replaceFirst('5', '9665');
    } else if (Phone.toString().startsWith('00')) {
      _mobile = Phone.toString().replaceFirst('00', '');
    } else if (Phone.toString().startsWith('+')) {
      _mobile = Phone.toString().replaceFirst('+', '');
    } else {
      _mobile = Phone;
    }
    notifyListeners();
  }

  Future<void> sendForm(BuildContext context, String name, String mobile, String title, String details) async {
    var url = 'https://tadawl-store.com/API/api_app/contactUs/contactForm.php';
    var data = {
      'name': name,
      'mobile': mobile,
      'title': title,
      'details': details,
    };
    var res = await http.post(url, body: data);
    if (jsonDecode(res.body) == 'true') {
      await Fluttertoast.showToast(
          msg: 'تم إرسال النموذج بنجاح، سيتم التواصل معك بأقرب فرصة.',
          toastLength: Toast.LENGTH_SHORT);
      // Provider.of<MainPageProvider>(context, listen: false).removeMarkers();
      Provider.of<LocaleProvider>(context, listen: false).setCurrentPage(0);
      // Provider.of<MainPageProvider>(context, listen: false).setRegionPosition(null);
      // Provider.of<MainPageProvider>(context, listen: false).setInItMainPageDone(0);
      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
              (route) => false
      );
    } else {
      await Fluttertoast.showToast(
          msg: 'Error', toastLength: Toast.LENGTH_SHORT);
    }
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setDetails(String details) {
    _details = details;
    notifyListeners();
  }

  void setExpanded(int index, bool isExpanded) {
    _data[index].isExpanded = !isExpanded;
    notifyListeners();
  }

  String get name => _name;
  String get mobile => _mobile;
  String get title => _title;
  String get details => _details;
  List<Item> get data => _data;
}
