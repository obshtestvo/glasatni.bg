user = User.create({ name: "Гражданин", password: SecureRandom.hex, email: "test@user.com" })
sceptic = User.create({ name: "Скептик", password: SecureRandom.hex, email: "second@user.com" })

AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')

p "Imported #{User.count} users"

# themes
first_theme = Theme.create({ name: "Неправителствени организации", info: "Много хора не знаят с какво се занимават неправителствените организации. Други смятат, че те служат за прокарване на чуждестранно влияние. И освен това – каква подкрепа от държавата – нали са неправителствени организации? Ако започнат да получават пари, нали ще станат зависими или дори “правителствени” организации. Надяваме се всички тези въпроси да бъдат обсъдени в дискусиите по-долу." })
second_theme = Theme.create({ name: "Гражданско участие", info: "За да разбереш, че живееш в демократична страна, със сигурност трябва да можеш свободно да казваш какво мислиш, да можеш сам или заедно с други, които мислят като теб, да се събирате, да предприемате определени действия, да променяте. Възможно е, дори и ако си сам, гласът ти да бъде чут, но вероятно държавата ще иска да види, че много хора застават зад твоето искане. Независимо дали си сам или сте повече, демократичната практика изисква Държавата да отговори на твоето искане с конкретни аргументи защо „да“ или „не“.\r\n\r\nДай предложения как България да стане по-демократична и по-гражданска." })
third_theme = Theme.create({ name: "Доброволчество", info: "Доброволчеството е призвание, ценност, преживяване, но за държавата, обществото, човекът в нужда – то е нещо много повече. Доброволци помагат на деца без родители, пазаруват за възрастни хора, спасяват природата. Доброволците даряват най-ценното, което имат – своето време, както и своя труд, знания и опит, и така решават проблеми, с които държавата не може или не иска да се справи. Обществото следва да цени високо доброволческия си ресурс, а държавата...? Как и кой следва да гарантира техните права, безопасност и информираност, когато правят „добро” – вашите коментари и предложения имат значение." })
fourth_theme = Theme.create({ name: "Гражданско образование", info: "Всички искаме да живеем в „различна“ България – която е по-модерна, по-уредена, и зачитаща всеки с неговите нужди и права. За да се случи това, се изискват добри закони и строги правила, реформи и инвестиции в икономиката, образованието и други сфери от обществения живот, но също така - и в подготвени хора, които знаят защо България трябва да е демократична, защо гражданите трябва да имат права и защо мнението на всеки е важно.\r\n\r\nГражданското образование насърчава децата да развиват нови модели на общуване, да формират определени знания и умения, които да им позволят да вземат информирани решения и в перспектива да могат успешно да защитават лична или обществена кауза, учи ги да изслушват и уважават позицията на другия, и най-вече активно да участват в обществения живот и да търсят решения по проблемите, които ги вълнуват." })
Theme.create({ name: "Как да подобрим платформата", info: "Ние, активните граждани, заслужаваме платформа, която да ни дава възможност да участваме в обществения живот по приятен и полезен начин. Ето защо „Мета тема“ е необходима. Тук ще предлагаме и обсъждаме промени в сайта, както във функционалността му, така и в правилата, на които стъпват модераторите, за да осъществяват правомощията си.\r\n\r\nКакто от нас зависи в каква държава живеем, така от нас зависи какво представлява и как е управляван този сайт." })

p "Imported #{Theme.count} themes"

proposals = [
{ title: "Държавата трябва да отделя средства за финансиране на проекти/идеи/инициативи на неправитествени организации. Финансирането на неправителствени организации трябва да става на конкурсен принцип.",
  content: "Много от **политиките** на държавата са били инициативи, стартирани от неправителствени организации (например Фонд Ин витро, чрез който държавата дава пари за ин витро опити на семейства; услугата приемен родител, която беше развивана по проекти на неправителствени организации преди държавата да реши да я подкрепя и много други). Държавата трябва да отделя пари за финансиране на инициативи на неправителствени организации, за да имат шанс и други подобни добри идеи да се реализират. Това трябва **да става на конкурсен принцип, публично и прозрачно**, защото това ще позволи състезание на различни идеи и по този начин намиране на най-добрите решения.\r\n\r\n**Според нас трябва**: \r\n\r\n- Държавата ежегодно да заделя публичен ресурс, с който да финансира граждански проекти и инициативи на конкурсен принцип;\r\n- Този публичен ресурс да бъде обособен под формата на самостоятелен Фонд за подкрепа на граждански организации, чийто статут, дейност, управление да са законово регламентирани;\r\n- НПО да участват при определяне на приоритетите за финансиране от Фонда.",
  theme: first_theme,
  user: user },

{ title: "Да бъдат променени статистическите отчети на неправителствените организации, така че да предоставят такава информация, с която да бъде изчислен икономическият и социалният ефект от тяхната дейност",
  content: "**Мотиви**:\n\nМного често неправителствените организации биват обвинявани, че вършат дейност без ефект, прахосват средства или не работят в интерес на хората, а на чуждестранните си донори. Ако се събира добра информация за дейността и финансирането на неправителствените организации, ще може да се анализира каква заетост осигурява неправителственият сектор и какъв дял има в икономиката на страната, както и какъв е социалният ефект от дейността му. В развитите страни почти 5% от брутния вътрешен продукт се изработва от неправителствения сектор. Събирането на информация ще помогне на държавата да има съответна/адекватна политика по отношение на неправителствените организации. \n\n**Според нас трябва**:\n\n- Промяна на категориите информация, която се събира от НПО чрез статистическите отчети;\n- В анализа/бюлетина на НСИ за всяка една година да се включва част, която да представя икономическия и социален ефект от дейността на НПО.",
  theme: first_theme,
  user: user },

{ title: "Министерски съвет да поддържа единна общодостъпна база данни, в която държавните институции да са длъжни да публикуват информация за това на коя неправителствена организация, за какво, по какъв ред и колко пари са дали.",
  content: "**Мотиви**:\n\nРазличните министерства отпускат финансиране за неправителствени организации, много често непрозрачно и без ясни правила. Създавайки единна база данни за предоставените от всички държавни институции финансирания на неправителствени организации, ще бъде видимо за всеки какви средства и за какво се отпускат на неправителствени организации, кои са тези организации, има ли правителството свои “фаворити” и какво правят те всъщност.\n\n**Според нас трябва**:\n\n- Всяка държавна институция, която разпределя публични средства, да публикува на коя НПО, какви пари, за какво и по какъв ред е дала;\n- Тази информация да се събира, съхранява и предоставя на обществото чрез единна електронна база данни, достъпна онлайн;\n- Тази информация да се актуализира периодично и в кратки срокове.",
  theme: first_theme,
  user: user },

{ title: "Законът следва да урежда лесна, бърза и евтина процедура по създаване на неправителствени организации",
  content: "**Мотиви**:\n\nНеправителствените организации са инструмент, чрез който активни граждани се обединяват, за да изразяват свои общи идеи, да постигат общи цели и да ги защитават пред властта. Активните граждани са предпоставка за по-развита държава. Те са тези, които гласуват, те са тези, които правят предложения за подобряване на ситуацията и те са тези, които се опитват да решават проблемите в страната, а не да емигрират. В Естония можеш да регистрираш НПО дори през мобилния си телефон, а в България през 2014 г. това отнема между 1 и 3 месеца, минимум 200 лева за такси и подготовката на не малък брой документи. Вместо държавата да неглижира и дори публично да заклеймява хората, имащи различна позиция, тя трябва да подкрепя развитието на алтернативни идеи. \n\n**Според нас трябва**: \n\n- Възможност за регистрацията на НПО по електронен път (по подобие на регистрацията на фирмите в Агенция по вписванията);\n- Прехвърляне на регистрацията на НПО от съда в Агенция по вписванията; \n- Безплатно пререгистриране на учредени в съда НПО в Агенция по вписванията.",
  theme: first_theme,
  user: user },

{ title: "Граждани и граждански организации да имат запазено право да попълват не по-малко от 1/3 от местата с право на глас в състава на всеки консултативен орган, създаден към национална или местна институция",
  content: "**Мотиви**: \n\nУчастието в процеса на вземане на решения означава не само да можеш да даваш предложения, но и да можеш да участваш в обсъждането, одобрението или отхвърлянето на тези предложения. В момента администрацията няма задължение да включва гражданския глас в дебатите – това е въпрос на добра воля.  Много често различните обществени/консултативни съвети чисто формално канят представители на граждански организации или граждани, само за да „отчетат“ гражданско участие.  Задължителната квота, запазена за НПО и граждани, ще допринесе дебатите да бъдат по-задълбочени, повече аргументи да бъдат чути и всички гледни точки - обсъдени. \n\n**Според нас трябва**:\n\n- в Закона за администрацията да има изричен текст, който да предвижда задължително участие на НПО и граждани в състава на консултативни органи;\n- Квотата на НПО и гражданите да е поне 1/3 от общия състав на подобни консултативни органи;\n- Представителите на НПО, които се включват в състава, да бъдат избирани чрез прозрачен и публичен механизъм.",
  theme: second_theme,
  user: user },

{ title: "Държавните институции трябва да се задължат да дават мотивиран отговор защо отхвърлят предложения на граждани и организации, когато се отнасят до промени в нормативни актове, стратегии и други решения на държавните институции",
  content: "**Мотиви**: \n\nЗаконът за нормативните актове изисква задължително публикуване онлайн на всички проекти за промени в закони и други актове на държавните органи. Много често „заинтересованите“ граждани дават мнения и становища, но администрацията не е длъжна да даде аргументи защо е приела едни или отхвърлила други предложения. Така формално „консултативният“ процес е спазен, но истината е, че реално обсъждане на постъпили мнения и становища няма. Всеки глас трябва да бъде чут и е важно най-добрите решения, основани на най-силни мотиви, да бъдат приети, тъй като касаят всички ни и чрез тях се харчат нашите пари. \n\n**Според нас трябва**:\n\n- В Закона за нормативните актове и в закона за администрацията да има правила, които да задължават институциите да отговарят мотивирано на постъпили от НПО и граждани предложения, но неприети от администрацията.",
  theme: second_theme,
  user: user },

{ title: "Повече публичност на народните представители – за кой и какво работят (гласуват)",
  content: "**Мотиви**:\n\nЯсно е към коя политическа сила принадлежат народните представители, имуществото им също е публично, тъй като ежегодно подават декларация към Сметната палата. Това, което не знаем, е как са гласували по законопроектите, колко често са били в Парламента, правили ли са изказвания и др. За гражданите (които всъщност са техните работодатели) е важно да знаят колко често народните представители ходят на работа (участват в работата на парламента), как работят (как гласуват, участват в дискусии, срещат се с граждани), колко са се отдалечили от предизборните си обещания... \n\n**Според нас трябва**:\n\n- Правилникът на Народното събрание да изисква публичност относно колко и какви предложения е внесъл всеки депутат, и как е гласувал по останалите предложения; \n- Тази информация да се публикува на сайта на Парламента и своевременно и периодично да се актуализира; \n- Правилникът на Народното събрание следва да предвижда задължително публикуване кой народен представител колко пъти е присъствал в Парламента.",
  theme: second_theme,
  user: user },

{ title: "Да има широко обществено обсъждане за Закон за доброволчеството",
  content: "**Мотиви**: България е сред малкото държави в Европа, които нямат законова рамка надоброволчеството. Държавата се ползва от доброволческия труд, защото той по правило посреща обществени нужди, за които тя трябва да отдели ресурс. Често застъпвана теза е, че е време и доброволците да се ползват от защитата и подкрепата на държавата – която да създаде ясни правила и гаранции, т.е. да приеме закон. В същото време проекти на закони за доброволчеството в миналото са създавали предпоставки за задушаване, а не за развиване на малкото покълнала доброволческа култура в България, изисквайки задължителни застраховки, задължителна регистрация на лични данни и покриване на всички разходи на всички доброволци – без значение дали става дума за еднократна инициатива, организирана от гражданин, неформална група или малкa НПО, или за дългосрочно доброволчество към голяма организация. Подобен подход към one size fits all закон е грешен и опасен, ето защо смятаме, че всеки бъдещ проект на Закон за доброволчеството трябва да бъде написан с участието на НПО и активни доброволци и след внимателно и неприбързано обсъждане с всички заинтересовани страни. \n\n**НИЕ ИСКАМЕ** евентуалният бъдещ закон за добрволчеството да бъде написан и внесен с участието на НПО и активни доброволци и след внимателно и неприбързано обсъждане с всички заинтересовани страни.",
  theme: third_theme,
  user: user },

{ title: "Разходите, направени от доброволците при предоставяне на доброволен труд, когато са им възстановени, да не се считат за доход на доброволеца",
  content: "**Мотиви**: \n\nДоброволците даряват своето време, знания и опит в полза на друг и това е тяхното желание и цел. Много често обаче се налага те да платят билет за транспорт или да купят специална екипировка, за да могат в крайна сметка да бъдат доброволци. Tези разходи не винаги могат да бъдат предварително предвидени и поети от организациите, които набират доброволци и организират доброволчески кампании. Понякога обаче разходите на доброволците могат да бъдат възстановени. В тези случаи е редно получените пари да не се считат за доход на доброволците, защото те не са „възнаграждение”. В противен случай изпадаме в абсурдната ситуация, в която човек дарява своето време, знания, опит и това даряване води до реализиране на „доход”, за който плаща данък. \n\nНИЕ ИСКАМЕ изрично да бъде записано че възстановените разходи на доброволците при полагане на доброволческия труд не са доход и не подлежат на облагане с данък или осигуровки.",
  theme: third_theme,
  user: user },

{ title: "Държавата трябва да подкрепя и насърчава доброволчеството чрез финансиране за организациите, които го инициират",
  content: "> Ако искаме нашите надежди за изграждането на един по-добър и по-сигурен свят да са нещо повече от просто желание, повече от всякога ще имаме нужда от работата на доброволци.\n\nКофи Анан\n\n**Мотиви**:\n\nЗа да се случват доброволчески инициативи не е достатъчно да има само добро желание. Необходими са средства, с които да се покриват разходи по набиране и мотивиране на хората да даряват безвъзмездно своя труд. Практиката показва, че доброволчеството допринася за решаване на проблеми от значение за цялото общество или за отделни местни общности. Тази добавена стойност на доброволния труд е отчетена в политиката на редица развити страни, както и в приоритетите на Европейския съюз и ООН. В България, все още признанието се случва в медийното пространство и Интернет, без да има целенасочена и дългосрочна държавна политика, която да осигурява финансиране, което да стимулира и подпомага развитието на доброволчеството. \n\nНИЕ ИСКАМЕ изрично да бъде предвидено ежегодно финансиране за обучения на доброволци, които средства да се получават от доброволчески организации.",
  theme: third_theme,
  user: user },

{ title: "Защо е важно нашите деца да знаят какво е да си гражданин?",
  content: "**Според нас трябва**:\n\nДа бъде разработена **детайлна концепция за гражданско образование**, която да се постави на широко обществено обсъждане, и да бъде подкрепена с ясен план на действие, мерки, отговорници и източници на финансиране. Концепцията трябва да отговори на въпроса дали **гражданското образование в България следва да се преподава и учи като отделен предмет** или да запази своя интегриран  характер както е в момента. Необходимо е да се предприеме и **анализ и актуализация на учебното съдържание, както и на методите и формите на преподаване на гражданското образование**. \n\n**Мотиви**:\n\nГражданското образование способства изграждането на гражданска компетентност, която включва определен набор от знания, умения и отношение. Безспорно е, че в момента гражданското образование в българското училище се осъществява по-скоро на теоретично равнище и се пренебрегва неговата практическа насоченост и приложен характер. Пренебрегва се и тази особеност на гражданската проблематика, която превръща гражданското образование в интерактивна дейност, поощряваща инициативността, креативността и отговорността на учениците. \n\nПредставянето на българските ученици в международното изследване в гражданското образование [ICCS](http://www.ckoko.bg/upload/docs/2013-01/ICCS_BGR_doklad.pdf), което е под средното равнище на всички участници в изследването, дава основания да се смята, че една от основните проблемни области е свързана с учебното съдържание.",
  theme: fourth_theme,
  user: user },

{ title: "Как да се повиши качеството на гражданското образование в България?",
  content: "**Според нас трябва**:\n\nДа се осигури необходимата форма за **системна квалификация на учителите** в областта на гражданското образование и **въвеждане на интерактивните методи** на преподаване, както и **ефективни форми на контрол** и измерване на постигнатите резултати.\n\n**Мотиви**:\n\nБез съмнение квалификацията на учителите е ключов фактор за постигане на високо качество на образованието. Особеностите на гражданското образование поставят много високи изисквания към квалификацията и подготовката на учителите, които преподават тази проблематика. В същото време, данните от изследване за гражданското образование и гражданската активност показват, че само 14 % от учителите използват методи и форми на преподаване, при които учениците участват в ролеви игри и симулации. Почти половината от тях посочват, че не се чувстват достатъчно уверени да преподават: икономика и бизнес, глобално гражданство, доброволчески групи, медии, глобално общество и международни организации и др. След като учителите са задължени да преподават ГО, то следва не просто да имат възможност за квалификация, а и задължително да бъдат квалифицирани и то по системен и устойчив начин.",
  theme: fourth_theme,
  user: user },

{ title: "Припознаване ролята на училището като институция, която трябва да поощрява гражданската инициатива и участие на учениците.",
  content: "**Според нас трябва**: \n\nВсяко училище да има политика за насърчаване развитието и талантите на всяко дете и включването на децата в различни клубове по интереси и доброволчески инициативи. Необходимо е и да се насърчава ролята на ученическите съвети, които да участват активно в управлението на училището и да се популяризира националната олимпиада по гражданско образование и коментирането на актуални теми от учениците в реално време.\n\n**Мотиви**: \n\nУчилището само по себе си е институцията, която има водеща роля за подготовката на младите хора като автономни и отговорни граждани, които имат съзнание за своята ценност и роля в обществото. Училището следва да поощрява учениците да мислят самостоятелно, да отстояват позициите си и да поемат отговорност за действията си. За тази цел училището само по себе си трябва да се превърне в територия за гражданска изява на своите ученици. Насърчаването на детското участие следва да е един от задължителните принципи на обучението в училище. Това включва политика за насърчаване развитието и талантите на всички деца,  въвличането им в различни доброволчески инициативи, които променят училището, квартала, града  и др., както и насърчаването на клубове по интереси между децата. Участието на децата в подобни инициативи ще подкрепи тяхното психо-емоционално и социално израстване, както и ще демонстрира на практика, че промените зависят от всеки.",
  theme: fourth_theme,
  user: user },

]

Proposal.create(proposals)

p "Imported #{Proposal.count} proposals"

comments = [
  {
    content: "Вече са направени стъпки в тази посока. Особено по третата точка - на страницата на Народното събрание има специална секция за „неизвинени отсъствия“.",
    user: sceptic,
    commentable: Proposal.find_by(title: "Повече публичност на народните представители – за кой и какво работят (гласуват)")
  }
]

Comment.create(comments)

p "Imported #{Comment.count} comment"

