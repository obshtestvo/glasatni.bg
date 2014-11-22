# glasani.bg

„Гласа ни“ е онлайн платформа за обсъждане на предложения от гражданите.
Някои от тези предложения могат да бъдат предложени за внедряване от
съответните институции с помощта на БЦНП.

## Полезни връзки

stage: [http://promeni.herokuapp.com/](http://promeni.herokuapp.com/)

## Относно

 „Ехо, има ли някой там?“. Този въпрос вероятно ще зададем, ако някой ден отидем на Марс. Сега обаче е важно да знаем – има ли някой тук, има ли граждани в България, които искат да кажат на вземащите решения как да променят държавата, средата. Kаним ви в тази платформа да коментирате какво мислите по въпроси като трябва ли децата да имат предмет гражданско образование, как могат гражданите ефективно да участват при правенето на закони, какво липсва за развитието на истинска доброволческа култура, кой и как да финансира гражданските инициативи. По-важното – ако дадете своите предложения по тези теми – това ще ви направи истински лидери на мнение в дискусията, с пряко участие в бъдещите законодателни инициативи на НПО. Glasani е платформа, в която менението ви е от значение.

## За програмисти

Платформата представлява *в някаква степен* one page app на angular с rails backend. Казвам „в някаква степен“, защото страниците свързани с devise *все още* не се зареждат през angular.

Ако:

1. имате идеи за подобряване на платфорамата в технически аспект - отворете github isssue;
2. имате идеи за подобряване на платформата от гледна точка на функционалност и дизайн - направете предложение в самата платформа в тема „Мета“ за да може да бъде видяна и обсъдена от цялата общност;
3. просто искате да се свържете с нас - пишете на info@obshtestvo.bg.

### Инсталация

1. Клонирайте си хранилището и влезте в папката.
2. Създайте си `config/application.yml` файл. Може да използвате примерния в `config/application.yml.example`.
3. `vagrant up`
4. `vagrant ssh` и настройте postgres
5. Сайтът трябва да е достъпен на `localhost:4567`

### Deployment

Инсталацията на приложението в продукционен режим може да се извърши по
много начини. Нашият избор е Capistrano за deployment, PostgreSQL база и Puma в
съчетание с Nginx за application server. Puma процесите се управляват от
[Jungle](https://github.com/puma/puma/tree/master/tools/jungle). Първоначалната
инсталация се прави с помощта на
[Capistrano::Puma](https://github.com/seuros/capistrano-puma).

Освен работеща PostgreSQL база, ще имате нужда и от header-файловете й, за да
може да се инсталира `pg` Ruby библиотеката. На Debian-базирани системи може
да инсталирате `libpq-dev` пакета.

Уверете се, че в environment променливите на потребителя, под чието име пускате
приложението, има `RAILS_ENV=production`.

1. Изпълнете локално `bundle exec cap production deploy:check`. Задачата ще
   създаде необходимите пътища и ще се оплаче, ако липсват необходимите
   конфигурационни файлове. Направете необходимите корекции и се уверете, че
   минава успешно.
2. В `shared/gov_production_nginx.conf` ще е създаден конфигурационен файл за
   Nginx. Може да го активирате като направите symlink към него от
   `/etc/nginx/sites-enabled`.
3. Инсталирайте Puma Jungle. Ако имате `sudo` права, може да използвате
   следната команда: `bundle exec cap production puma:jungle:setup`. Бихте
   могли временно да разрешите на потребител `www-data` да изпълнява sudo
   команди като добавите следното в `/etc/sudoers`:

        www-data    ALL=(ALL:ALL) NOPASSWD: ALL

   В противен случай, трябва да изпълните ръчно стъпките по инсталация, описани
   [в тази задача](https://github.com/seuros/capistrano-puma/blob/master/lib/capistrano/tasks/jungle.cap).
4. Трябва да може да се осъществи връзка с базата данни, конфигурирана в
   `shared/config/database.yml`.
5. Качете приложението с `bundle exec cap production deploy`.
6. На сървъра изпълнете `service nginx reload`.

### API

API-то е **unstable** на този етап. Може да търпи промени.

През АPI-то можете да търсите, събирате и обработвате информация за 3
неща: предложения, коментари и потребители.

#### Предложения

**Адрес: "/api/v1/proposals?[params]"**

Една заявка може да изглежда така:

`curl http://glasatni.bg/api/v1/proposals?order=newest&page=3&theme=ngo`

params могат да бъдат:

##### **theme**: [all, volunteering, ngo, participation, education, meta]

Сортира предложенията по тема. Темите са:

1. all - Всички теми;
2. volunteering - Доброволчество;
3. ngo - Неправителствени организации;
4. participation - Гражданско участие;
5. education - Гражданско образование;
6. meta - Мета тема.

##### **order**: [relevance, newest, oldest, most-comments, least-comments]

Този параметър задава подредбата на предложенията.

1. relevance - сортира по подкрепа;
2. newest - първи са първите;
3. oldest - първи са последните;
4. most-comments - първо темите с най-много коментари;
5. least-comments - първо темите с най-малко коментари.

##### **page**: [1...]

Ако параметъра не е специфизиран ще бъдат изпратени само
  първата страница. За да изтеглите цялата таблица е необходимо да
преминете през всички страници.

##### **voter_id**: [1...]

Ако бъде подадено id-то на даден потребител на сайта, може да бъде
видяно как е гласувал. На този сайт гласуването е явно ;)

Eдна заявка връща следнaта структура:

```javascript
{
  proposals: [
   {
     id: 2,
     user: {
       id: 1,
       name: "име"
     },
     title: "Заглавие",
     content: "съдържание",
      voted: null,
      theme: {
        id: 5,
        name: "Име на темата на бг"
      },
      up: 0,
      down: 0,
      hotness: 0,
      comments_count: 4,
      created_at: "2014-11-16T17:52:26.824+02:00",
      time_ago: "преди ден",
      updated_at: "2014-11-16T17:53:47.837+02:00"
    },
    ...
  ],
  proposals_count: 1,
  pages_count: 1,
  page: 1
}
```

В контретния случай сме подали voter_id, но потребителя не е гласувал и
поради това стойността е null. Ако беше гласувал с „+“ щеше да е 0, а с „-“ - 1. Ако не бяхме подали voter_id, нямаше да има стойност „voted“.

Възможно е също да бъде изтеглено конкретно предложение с:

`curl http://glasatni.bg/api/v1/proposals/1234`

#### Коментари

**Адрес: "/api/v1/comments?[params]"**

Една заявка може да изглежда така:

`curl http://glasatni.bg/api/v1/comments?order=newest&page=3`

params могат да бъдат:

##### **commentable_id**: [1...]

Сортира по предложение. За да видите коментарите на специфично
предложение, трябва да сложите за стойност неговото id.

##### **order**: [relevance, newest, oldest]

Този параметър задава подредбата на коментарите.

1. relevance - сортира по подкрепа;
2. newest - първи са първите;
3. oldest - първи са последните.

##### **page**: [1...]

Ако параметъра не е специфизиран ще бъдат изпратени само
  първата страница. За да изтеглите цялата таблица е необходимо да
преминете през всички страници.

##### **voter_id**: [1...]

Ако бъде подадено id-то на даден потребител на сайта, може да бъде
видяно как е гласувал. На този сайт гласуването е явно ;)

Eдна заявка връща следната структура:

```javascript
{
  comments: [
    {
      id: 2,
      content: "sdas",
      created_at: "2014-11-17T01:13:29.610+02:00",
      time_ago: "преди ден",
      updated_at: "2014-11-17T01:13:29.610+02:00",
      commentable: 8,
      comments_count: 0,
      user: {
        id: 3,
        name: "Петко Циков",
        comments_rank: "speaker",
        proposals_rank: "enthusiast",
        moderator: false
      },
      hotness: 0
    },
    ...
  ],
  comments_count: 9,
  pages_count: 3,
  page: 1
}
```

В контретния случай не сме подали voter_id и няма стойност „voted“.

Възможно е също да бъде изтеглен конкретен коментар с:

`curl http://glasatni.bg/api/v1/comments/1234`

#### Потребители

**Адрес: "/api/v1/users?[params]"**

Сортирането по потребители се извършва единствено на база ранг.

Примерна заявка изглежда така:

`curl http://glasatni.bg/api/v1/users?rank=orator`

params могат да бъдат eдинствено:

##### **rank**: [observer, speaker, orator, enthusiast, activist, policy_maker]

Eдна заявка връща следната структура:

```javascript
{
  users: [
    {
      id: 3,
      name: "Име",
      reputation: 2,
      comments_rank: "orator",
      proposals_rank: "enthusiast",
      moderator: true,
      created_at: "2014-11-16T17:52:56.763+02:00",
      time_ago: "преди ден",
      updated_at: "2014-11-18T16:31:46.927+02:00"
    },
    ...
  ],
  users_count: 14,
  pages_count: 1,
  page: 1
}
```

Възможно е също да бъде изтеглен конкретен потребител с:

`curl http://glasatni.bg/api/v1/user/1234`

