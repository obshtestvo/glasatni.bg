# test user
user = User.create({ name: "Гражданин", password: SecureRandom.hex, email: "test@user.com" })
sceptic = User.create({ name: "Скептик", password: SecureRandom.hex, email: "second@user.com" })
p "Imported #{User.count} users"

# themes
Theme.create({ name: "Гражданско участие", info: "За да разбереш, че живееш в демократична страна, със сигурност трябва да можеш свободно да казваш какво мислиш, да можеш сам или заедно с други, които мислят като теб, да се събирате, да предприемате определени действия, да променяте. Възможно е, дори и ако си сам, гласът ти да бъде чут, но вероятно държавата ще иска да види, че много хора застават зад твоето искане. Независимо дали си сам или сте повече, демократичната практика изисква Държавата да отговори на твоето искане с конкретни аргументи защо „да“ или „не“.
                                       Дай предложения как България да стане по-демократична и по-гражданска." })
Theme.create({ name: "Гражданско образование", info: "TBD" })
Theme.create({ name: "Доброволчество", info: "TBD" })
Theme.create({ name: "Мета", info: "TBD" })
Theme.create({ name: "Неправителствени организации", info: "Много хора не знаят с какво се занимават неправителствените организации. Други смятат, че те служат за прокарване на чуждестранно влияние. И освен това – каква подкрепа от държавата – нали са неправителствени организации? Ако започнат да получават пари, нали ще станат зависими или дори “правителствени” организации. Надяваме се всички тези въпроси да бъдат обсъдени в дискусиите по-долу." })

p "Imported #{Theme.count} themes"

proposals = [
{ title: "Държавата трябва да отделя средства за финансиране на проекти/идеи/инициативи на неправитествени организации. Финансирането на неправителствени организации трябва да става на конкурсен принцип.",
  content: "Много от **политиките** на държавата са били инициативи, стартирани от неправителствени организации (например Фонд Ин витро, чрез който държавата дава пари за ин витро опити на семейства; услугата приемен родител, която беше развивана по проекти на неправителствени организации преди държавата да реши да я подкрепя и много други). Държавата трябва да отделя пари за финансиране на инициативи на неправителствени организации, за да имат шанс и други подобни добри идеи да се реализират. Това трябва **да става на конкурсен принцип, публично и прозрачно**, защото това ще позволи състезание на различни идеи и по този начин намиране на най-добрите решения.\r\n\r\n**Според нас трябва**: \r\n\r\n- Държавата ежегодно да заделя публичен ресурс, с който да финансира граждански проекти и инициативи на конкурсен принцип;\r\n- Този публичен ресурс да бъде обособен под формата на самостоятелен Фонд за подкрепа на граждански организации, чийто статут, дейност, управление да са законово регламентирани;\r\n- НПО да участват при определяне на приоритетите за финансиране от Фонда.",
  theme: Theme.first,
  user: user },

{ title: "Да бъдат променени статистическите отчети на неправителствените организации, така че да предоставят такава информация, с която да бъде изчислен икономическият и социалният ефект от тяхната дейност",
  content: "**Мотиви**:\r\n\r\nМного често неправителствените организации биват **обвинявани**, че вършат дейност без ефект, прахосват средства или не работят в интерес на хората, а на чуждестранните си донори. Ако се събира добра информация за дейността и финансирането на неправителствените организации, ще може да се анализира каква заетост осигурява неправителственият сектор и какъв дял има в икономиката на страната, както и какъв е социалният ефект от дейността му. В развитите страни почти **5% от брутния вътрешен продукт се изработва от неправителствения сектор**. Събирането на информация ще помогне на държавата да има съответна/адекватна политика по отношение на неправителствените организации.\r\n\r\n**Според нас трябва**:\r\n\r\n- Промяна на категориите информация, която се събира от НПО чрез статистическите отчети;\r\n- В анализа/бюлетина на НСИ за всяка една година да се включва част, която да представя икономическия и социален ефект от дейността на НПО.",
  theme: Theme.first,
  user: user },

{ title: "Министерски съвет да поддържа единна общодостъпна база данни, в която държавните институции да са длъжни да публикуват информация за това на коя неправителствена организация, за какво, по какъв ред и колко пари са дали.",
  content: "**Мотиви**:\r\n\r\nРазличните **министерства** отпускат финансиране за неправителствени организации, много често непрозрачно и без ясни правила. Създавайки единна база данни за предоставените от всички държавни институции финансирания на неправителствени организации, ще бъде видимо за всеки какви средства и за какво се отпускат на неправителствени организации, кои са тези организации, има ли правителството свои „фаворити“ и какво правят те всъщност.\r\n\r\n**Според нас трябва**:\r\n\r\n- Всяка държавна институция, която разпределя публични средства, да публикува на коя НПО, какви пари, за какво и по какъв ред е дала;\r\n- Тази информация да се събира, съхранява и предоставя на обществото чрез единна електронна база данни, достъпна онлайн;\r\n- Тази информация да се актуализира периодично и в кратки срокове.",
  theme: Theme.first,
  user: user },

{ title: "Законът следва да урежда лесна, бърза и евтина процедура по създаване на неправителствени организации",
  content: "еправителствените организации са *инструмент*, чрез който **активни граждани** се обединяват, за да изразяват свои общи идеи, да постигат общи цели и да ги защитават пред властта. Активните граждани са предпоставка за по-развита държава. Те са тези, които гласуват, те са тези, които правят предложения за подобряване на ситуацията и те са тези, които се опитват да решават проблемите в страната, а не да емигрират.\r\n\r\nВ **Естония** можеш да регистрираш НПО дори през мобилния си телефон, а в България през 2014 г. това отнема между 1 и 3 месеца, минимум 200 лева за такси и подготовката на не малък брой документи. Вместо държавата да неглижира и дори публично да заклеймява хората, имащи различна позиция, тя трябва да подкрепя развитието на алтернативни идеи.\r\n\r\n**Според нас трябва**:\r\n\r\n- Възможност за регистрацията на НПО по електронен път (по подобие на регистрацията на фирмите в Агенция по вписванията);\r\n- Прехвърляне на регистрацията на НПО от съда в Агенция по вписванията;\r\n- Безплатно пререгистриране на учредени в съда НПО в Агенция по вписванията.",
  theme: Theme.first,
  user: user },

{ title: "Граждани и граждански организации да имат запазено право да попълват не по-малко от 1/3 от местата с право на глас в състава на всеки консултативен орган, създаден към национална или местна институция",
  content: "**Мотиви**:\r\n\r\nУчастието в **процеса на вземане на решения** означава не само да можеш да даваш предложения, но и да можеш да участваш в обсъждането, одобрението или отхвърлянето на тези предложения. В момента администрацията няма задължение да включва гражданския глас в дебатите – това е въпрос на добра воля. Много често различните обществени/консултативни съвети чисто формално канят представители на граждански организации или граждани, само за да „отчетат“ гражданско участие. Задължителната квота, запазена за НПО и граждани, ще допринесе дебатите да бъдат по-задълбочени, повече аргументи да бъдат чути и всички гледни точки - обсъдени.\r\n\r\n**Според нас трябва**: \r\n\r\n- в Закона за администрацията да има изричен текст, който да предвижда задължително участие на НПО и граждани в състава на консултативни органи;\r\n- Квотата на НПО и гражданите да е поне 1/3 от общия състав на подобни консултативни органи;\r\n- Представителите на НПО, които се включват в състава, да бъдат избирани чрез прозрачен и публичен механизъм.",
  theme: Theme.second,
  user: user },

{ title: "Държавните институции трябва да се задължат да дават мотивиран отговор защо отхвърлят предложения на граждани и организации, когато се отнасят до промени в нормативни актове, стратегии и други решения на държавните институции",
  content: "**Законът за нормативните актове** изисква задължително публикуване онлайн на всички проекти за промени в закони и други актове на държавните органи. Много често „заинтересованите“ граждани дават мнения и становища, но администрацията не е длъжна да даде аргументи защо е приела едни или отхвърлила други предложения. Така формално „консултативният“ процес е спазен, но истината е, че реално обсъждане на постъпили мнения и становища няма. Всеки глас трябва да бъде чут и е важно най-добрите решения, основани на най-силни мотиви, да бъдат приети, тъй като касаят всички ни и чрез тях се харчат нашите пари.\r\n\r\nСпоред нас трябва **в Закона за нормативните актове и в закона за администрацията да има правила, които да задължават институциите да отговарят мотивирано на постъпили от НПО и граждани предложения, но неприети от администрацията.**",
  theme: Theme.second,
  user: user },

{ title: "Повече публичност на народните представители – за кой и какво работят (гласуват)",
  content: "**Мотиви**:\r\n\r\nЯсно е към коя политическа сила принадлежат народните представители, имуществото им също е публично, тъй като ежегодно подават декларация към Сметната палата. Това, което не знаем, е как са гласували по законопроектите, колко често са били в Парламента, правили ли са изказвания и др. За гражданите (които всъщност са техните работодатели) е важно да знаят колко често народните представители ходят на работа (участват в работата на парламента), как работят (как гласуват, участват в дискусии, срещат се с граждани), колко са се отдалечили от предизборните си обещания...\r\n\r\n**Според нас трябва**:\r\n\r\n- Правилникът на Народното събрание **да изисква публичност** относно колко и какви предложения е внесъл всеки депутат, и как е гласувал по останалите предложения;\r\n- Тази информация **да се публикува** на сайта на Парламента и своевременно и периодично да се актуализира;\r\n- Правилникът на Народното събрание следва да предвижда задължително публикуване **кой** народен представител **колко пъти** е присъствал в Парламента.",
  theme: Theme.second,
  user: user } ]

Proposal.create(proposals)

p "Imported #{Proposal.count} proposals"

comments = [
  {
    content: "Вече са направени стъпки в тази посока. Особено по третата точка - на страницата на Народното събрание има специална секция за „неизвинени отсъствия“.",
    user: sceptic,
    commentable: Proposal.last
  }
]

Comment.create(comments)

p "Imported #{Comment.count} comment"

