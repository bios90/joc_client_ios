import Foundation

enum MyStrings:String
{
    case ok = "Ok"
    case cancel = "Отмена"
    case authorization = "Авторизация"
    case make_auth_for = "Пройдите авторизацию для ...."
    case enter_phone_number = "Введите ваш номер телефона"
    case enter_sms_code = "Введите код подтверждения"
    case send = "Отправить"
    case authorization_allows_you = "Авторизация позволит вам делать заказы, отслеживать статус заказа, оставлять отзывы а так же многое другое. Пройдите процесс регстирации прямо сейчас, это займет не больше 1 минуты."
    case send_code = "Выслать код"
    case confirm = "Подтвердить"
    case its_clear = "Понятно"
    case please_fill = "Пожалуйста заполните поле"
    case code = "Код"
    case please_confirm_offert = "Пожалуйста подтвердите согласие с оффертой"
    case no_internet_connection = "Отсутствует соединение с сетью"
    case error_default = "Возникла ошибка при выполнении запроса. Повторите позже."
    case error_parsing = "Возникла ошибка при обработке запроса."
    case loading = "Загрузка"
    case name = "Имя"
    case phone = "Телефон"
    case email = "Email"
    case filter = "Фильтр"
    case average_cup_price = "Средняя цена за стакан"
    case cafe_type = "Тип заведения"
    case rating = "Рейтинг"
    case from = "От"
    case all = "Все"
    case coffee_spot = "Кофе точка"
    case cafe = "Кафе"
    case apply = "Применить"
    case by_distance = "По расстоянию"
    case by_rating = "По рейтингу"
    case hot_drinks = "Горячие напитки"
    case cold_drinks = "Холодные напитки"
    case snacks = "Закуски"
    case no_sugar = "Без сахара"
    case add = "Добавить"
    case sum = "Сумма"
    case weight = "Объем"
    case sugar = "Сахар"
    case milk = "Молоко"
    case addables = "Добавки"
    case product_added_to_basket = "Продукт добавлен в корзину"
    case product_changed = "Продукт изменен"
    case basket = "Корзина"
    case delete = "Удалить"
    case edit = "Редактировать"
    case save = "Сохранить"
    case cafe_cant_take_payment = "Данное кафе пока не принимает оплату"
    case need_register_to_make_order = "Для оформления заказа необходимо зарегестрироваться"
    case make_offer = "Оформить"
    case quick_order = "Быстрый заказ"
    case registration = "Регистрация"
    case making_time = "Время приготовления"
    case time = "Время"
    case comment_to_order = "Комментарий к заказу"
    case pay = "Оплатить"
    case basket_is_empty = "Корзина пуста"
    case payment = "Оплата"
    case order_in_app_joc = "Оплата заказа в приложении JustOrderCompany"
    case order_number = "Номер заказа"
    case repeat_word = "Повторить"
    case make_cancel = "Отменить"
    case review = "Отзыв"
    case more = "Ещё"
    case close = "Закрыть"
    
    
    func localized() -> String
    {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    static func getIAgreeWithOffert()->NSMutableAttributedString
    {
        let attr_reg = [ NSAttributedString.Key.font: MyFonts.gi.reg_s,NSAttributedString.Key.foregroundColor: MyColors.gi.gray6]
        let attr_bold = [ NSAttributedString.Key.font: MyFonts.gi.bold_s,NSAttributedString.Key.foregroundColor: MyColors.gi.gray8]
        
        let final_text = NSMutableAttributedString()
        final_text.append(NSAttributedString(string: "Я согласен с условиями ", attributes: attr_reg))
        final_text.append(NSAttributedString(string: "офферты", attributes: attr_bold))
        
        return final_text
    }
    
    static func getOffertText()->String
    {
        return """
        <p dir="ltr">
        ПОЛЬЗОВАТЕЛЬСКОЕ СОГЛАШЕНИЕ МОБИЛЬНОГО ПРИЛОЖЕНИЯ JOC
        </p>
        <p dir="ltr">
        1. ОБЩИЕ ПОЛОЖЕНИЯ
        </p>
        <p dir="ltr">
        1.1. Настоящее положение разработано в целях информирования пользователей
        мобильного приложения JOC об условиях пользования Мобильным приложением
        JOC. Настоящее Пользовательское соглашение представляет собой предложение
        Пользователю использовать Сервис JOC.
        </p>
        <p dir="ltr">
        1.2. Начиная использовать Сервис/его отдельные функции, Пользователь
        считается принявшим Пользовательское соглашение, а также условия
        сопутствующих документов, в полном объеме, без всяких оговорок и
        исключений. В случае несогласия Пользователя с какими-либо из положений
        Пользовательского соглашения и/или Регулирующих документов, Пользователь не
        вправе использовать Сервис.
        </p>
        <p dir="ltr">
        1.3. Агрегатор вправе в любое время изменить положения Пользовательского
        соглашения, а также сопутствующих документов. Пользователи уведомляются о
        прекращении действия или об изменении условий настоящего Положения путем
        опубликования соответствующей информации в Мобильном Приложении. Условия
        считаются измененными и/или отмененными с момента, указанного в
        соответствующем уведомлении в Мобильном Приложении. Риск неознакомления с
        новой редакцией Пользовательского соглашения и Регулирующих документов
        несет Пользователь, продолжение пользования Сервисом после изменения
        Пользовательского соглашения или Регулирующих документов считается
        согласием с их новой редакцией.
        </p>
        <p dir="ltr">
        1.4. Используя Сервис, Пользователь дает свое согласие на получение
        сообщений рекламного характера от Агрегатора.
        </p>
        <p dir="ltr">
        1.5. Использование отдельных функций Сервиса, в том числе оформление
        Заказа, доступно Пользователю после прохождения регистрации и авторизации
        на Сервисе. При регистрации Пользователь обязуется предоставить данные о
        себе, запрашиваемые на Сервисе в форме регистрации, а также указать адрес
        электронной почты, который будет использоваться в качестве логина, и
        пароль. Пользователь обязуется не передавать логин и пароль, присвоенные
        ему при регистрации, третьим лицам, а также обеспечивать сохранность и
        конфиденциальность логина и пароля.
        </p>
        <p dir="ltr">
        1.6. Оформляя Заказ, Пользователь подтверждает, что а) полностью
        ознакомился с положениями Пользовательского соглашения и сопутствующих
        документов, б) полностью понимает Пользовательское соглашение и
        сопутствующие документы в) полностью понимает значение и последствия своих
        действий в отношении заключения и исполнения Договора с Рестораном и/или
        Доставщиком.
        </p>
        <p dir="ltr">
        1.7. Пользователь соглашается не предпринимать действий и не оставлять
        комментарии и записи, которые могут рассматриваться как нарушающие
        российское законодательство или нормы международного права, в том числе в
        сфере интеллектуальной собственности, авторских и/или смежных прав,
        общепринятые нормы морали и нравственности, а также любых действий, которые
        приводят или могут привести к нарушению нормальной работы Мобильного
        Приложения и его сервисов.
        </p>
        <p dir="ltr">
        1.8. Использование материалов Мобильного Приложения без согласия
        правообладателей не допускается.
        </p>
        <p dir="ltr">
        1.9. При цитировании материалов Мобильного Приложения, включая охраняемые
        авторские произведения, ссылка на автора обязательна.
        </p>
        <p dir="ltr">
        2. ТЕРМИНЫ И ОПРЕДЕЛЕНИЯ
        </p>
        <p dir="ltr">
        2.1. В целях настоящего документа нижеприведенные термины используются в
        следующем значении:
        </p>
        <p dir="ltr">
        2.2. Пользовательское соглашение — настоящий документ, размещенный при
        регистрации в Мобильном приложении.
        </p>
        <p dir="ltr">
        2.3. Агрегатор – Индивидуальный предприниматель Лекан Александра
        Владимировна, ОГРНИП: 320745600066981, ИНН 02200572411, обеспечивающая
        информационно-технологическое сопровождение взаимодействия между
        Пользователями приложения, оформляющими предзаказ на приготовление еды и
        блюд на вынос, а также представителями заведений питания (кафе, рестораны,
        кофейни и иные), использующими полученные заявки для оказания услуг
        Пользователям, оформившим предзаказ. Агрегатор оказывает Пользователям
        информационные услуги по предоставлению информации в Мобильном приложении и
        проверке оставленной информации.
        </p>
        <p dir="ltr">
        2.4. Пользователь – физическое лицо, подтвердившее свое намерение
        пользоваться Услугами Агрегатора и использовать функционал мобильного
        приложения путем присоединения к настоящему Положению. (акцепта настоящего
        Соглашения);
        </p>
        <p dir="ltr">
        2.5. Авторизованный пользователь — Пользователь, авторизовавшийся на
        Сервисе с помощью логина и пароля, присвоенных ему при регистрации.
        </p>
        <p dir="ltr">
        2.6. Исполнитель – юридическое лицо, индивидуальный предприниматель,
        реализующий работы и услуги Пользователям в области питания, приготовления
        еды и различных блюд (либо агент/комиссионер/иной представитель указанного
        лица);
        </p>
        <p dir="ltr">
        2.7. Заказ — оформленный Пользователем на Сервисе заказ работы или услуги,
        в результате которого Пользователь заключает договор о приготовлении и/или
        реализации услуги с Поваром, на условиях, определенных соглашением Сторон;
        </p>
        <p dir="ltr">
        2.8. Работы / Услуги — деятельность исполнителя по приготовлению и выдаче
        пищевой продукции и напитков, приготовление которых для Пользователей и/или
        реализацию которых Пользователям осуществляет Исполнитель в результате
        оформления Пользователем Заказа на Сервисе.
        </p>
        <p dir="ltr">
        2.9. Договор — договор о приготовлении Товара и/или реализации работы или
        услуги с Исполнителем, заключаемый между Пользователем и Исполнителем в
        результате оформления Заказа.
        </p>
        <p dir="ltr">
        2.10. Мобильное Приложение JOC — программа «JOC» для мобильных устройств,
        предоставляемая Пользователям и Исполнителям на условиях настоящего
        пользовательского соглашения.
        </p>
        <p dir="ltr">
        2.11. Сервис JOC — означает все веб-сайты (включая, но не ограничиваясь,
        размещенными в сети Интернет по адресу:    <a href="https://justordercompany.com">https://justordercompany.com</a>,
        программы для ЭВМ (в том числе Приложение JOC, иные программы для мобильных
        устройств), предоставляющие Пользователю Сервиса возможность осуществить
        Заказ на условиях, предусмотренных в настоящем Пользовательском соглашении.
        </p>
        <p dir="ltr">
        3. ПОРЯДОК И УСЛОВИЯ ОФОРМЛЕНИЯ ЗАКАЗА НА СЕРВИСЕ
        </p>
        <p dir="ltr">
        3.1. Оформление Заказа доступно только Авторизованному пользователю. До
        момента оформления Заказа работы/услуги на Сервисе Пользователь обязуется
        ознакомиться со всеми условиями приготовления и/или реализации, а также
        условиями выдачи заказа, определенными Исполнителем.
        </p>
        <p dir="ltr">
        3.2. Пользователь при оформлении Заказа заключает Договор с Исполнителем и
        вступает в прямые договорные отношения с Исполнителем в части реализации
        Услуги.
        </p>
        <p dir="ltr">
        3.3. Оформляя Заказ, Пользователь соглашается с тем, что Исполнитель может
        поручить исполнение Договора третьему лицу, при этом оставаясь
        ответственным за его исполнение.
        </p>
        <p dir="ltr">
        3.4. Все права и обязательства по заключаемому с Пользователем Договору
        (Договорам) возникают непосредственно у Исполнителя.
        </p>
        <p dir="ltr">
        3.5. Пользователь подтверждает свое согласие с тем, что персональная
        информация, которую Пользователь предоставляет Агрегатору при использовании
        Сервиса, в том числе при оформлении Заказа, может быть передана Агрегатором
        Исполнителю, с которым Пользователь заключает Договор в результате
        оформления Заказа, для целей исполнения Исполнителем указанного Договора с
        Пользователем.
        </p>
        <p dir="ltr">
        3.6. Оформляя заказ на Сервисе, Пользователь соглашается на получение
        электронных писем, которые Агрегатор может направить Пользователю: после
        оформления Заказа; в случае его изменения; в случае, влияющем на исполнение
        Заказа или своевременное информирование о его статусе, сообщений (SMS) на
        телефонный номер, указанный Пользователем, а также звонка с предложением
        оценить качество работы Сервиса, Исполнителя на телефонный номер, указанный
        Пользователем.
        </p>
        <p dir="ltr">
        3.7. Пользователь обязан указать достоверные данные о себе и получателе
        Заказа при оформлении Заказа на Сервисе. Пользователь несет ответственность
        за все последствия, вызванные недостоверностью предоставленной им
        информации.
        </p>
        <p dir="ltr">
        3.8. Для оформления Заказа Пользователь, ознакомившись с информацией о
        услуге, указывает с помощью Сервиса все необходимые для исполнения Договора
        Исполнителем данные, включая, но не ограничиваясь: персональная информация
        Пользователя, указывает в случае необходимости адрес места выдачи
        предзаказа, ФИО получателя, контактные данные (номер телефона, иные).
        </p>
        <p dir="ltr">
        3.9. Пользователь, оформивший Заказ, обязан забрать его по выбранному
        адресу Исполнителя. В случае отсутствия Пользователя по адресу выдачи
        Заказа, а равно как в случае невозможности вручения Товара Пользователю по
        причинам, возникшим в результате действий/бездействия Пользователя, а равно
        как в случае отказа Пользователя от принятия Услуги (за исключением Услуги
        ненадлежащего качества или не соответствующего условиям оформленного
        Пользователем Заказа), по истечении установленного в заказе конкретного
        времени передачи Продукции (или 7 минут в случае использования функции
        «быстрый заказ»), Пользователь считается отказавшимся от исполнения
        Договора (Договоров) с Исполнителем. Исполнитель вправе утилизировать
        приготовленную продукцию по истечении 10 (десяти) минут с момента
        указанного в заказе времени, в которое Пользователь обязался забрать заказ.
        </p>
        <p dir="ltr">
        3.10 Пользователь обязуется оплатить сформированный в Приложении заказ в
        момент его подтверждения. Обязательство по оплате считается исполненным с
        момента зачисления денежных средств на расчетный счет Агрегатора.
        </p>
        <p dir="ltr">
        3.11. Пользователь имеет право отменить заказ, но не позднее, чем за 5
        минут до передачи Продукции Потребителю в установленное время. В случае,
        если возврат был оформлен потребителем в установленные сроки, Агрегатор
        обязуется вернуть уплаченные за Продукцию денежные средства.
        </p>
        <br/>
        <p dir="ltr">
        4. ОТВЕТСТВЕННОСТЬ.
        </p>
        <p dir="ltr">
        4.1. Агрегатор не отвечает за неисправности, ошибки и сбои в работе
        программных и/или аппаратных средств, обеспечивающих функционирование
        Мобильного приложения, возникшие по причинам, не зависящим от Агрегатора, а
        также связанные с этим убытки Пользователя.
        </p>
        <p dir="ltr">
        4.2. Агрегатор не отвечает за временное отсутствие у Пользователя доступа к
        программным и/или аппаратным средствам, обеспечивающим функционирование
        Мобильного приложения, а также связанные с этим убытки Пользователя.
        </p>
        <p dir="ltr">
        4.3. Агрегатор не несет ответственности за какие-либо убытки и/или
        упущенную выгоду Пользователя и/или третьих лиц, утрату информации в
        результате использования или невозможности использования Мобильного
        приложения.
        </p>
        <p dir="ltr">
        4.4. Агрегатор не отвечает за убытки Пользователя, возникшие в результате
        неправомерных действий третьих лиц, в том числе связанных с неправомерным
        доступом к мобильному телефону, компьютеру или иному устройству
        Пользователя, позволяющему пользоваться Мобильным приложением.
        </p>
        <p dir="ltr">
        4.5. Агрегатор не отвечает за убытки, возникшие у Пользователя в результате
        применения Агрегатором ограничений на проведение платежей Пользователя,
        связанных с его обоснованным подозрением о ведении Пользователем незаконной
        деятельности, либо иного нарушения законодательства РФ с помощью Мобильного
        приложения.
        </p>
        <p dir="ltr">
        4.6. Агрегатор не отвечает за убытки Пользователя, возникшие в результате:
        </p>
        <p dir="ltr">
        4.6.1. Внесения Пользователем или третьими лицами изменений в программное
        обеспечение мобильного телефона, компьютера или иного устройства,
        позволяющего пользоваться Мобильным приложением, а также в результате
        наличия «вирусов» и иных вредоносных программ в указанных устройствах и
        программном обеспечении, используемом Пользователем для доступа к Системе.
        </p>
        <p dir="ltr">
        4.6.2. Неправильного указания Реквизитов Исполнителями, а также иной
        информации в Системе, необходимой для осуществления оплаты Услуг
        Исполнителей.
        </p>
        <p dir="ltr">
        4.6.3. Нарушения Пользователем Соглашения, Правил пользования Мобильным
        приложением, рекомендаций по его использованию, размещенных при регистрации
        в мобильном приложении.
        </p>
        <p dir="ltr">
        4.7. Пользователи и Исполнители несут всю ответственность за достоверность
        сведений, указанных ими при регистрации в Мобильном приложении и при
        дальнейшем его использовании. Агрегатор ни при каких условиях не отвечает
        за убытки Пользователя и Исполнителя, понесенные в результате отказа в
        возврате платежа и/или совершения иных действий по использованию Мобильным
        приложением вследствие невозможности идентификации Пользователя.
        </p>
        <p dir="ltr">
        4.8. Пользователь, Исполнитель и Агрегатор освобождаются от ответственности
        за полное или частичное неисполнение своих обязательств по Соглашению, если
        таковое явилось следствием обстоятельств непреодолимой силы, возникших
        после вступления в силу Соглашения, в результате событий чрезвычайного
        характера, которые не могли быть предвидены и предотвращены разумными
        мерами.
        </p>
        <p dir="ltr">
        4.9. Агрегатор является исключительно связующим звеном между Пользователями
        и Исполнителями и не несёт ответственность за исполнение или надлежащее
        исполнение обязательств по договору на оказание услуг, заключенному между
        такими Пользователями и Исполнителями.
        </p>
        <p dir="ltr">
        4.10. В других случаях неисполнения или ненадлежащего исполнения своих
        обязательств по Соглашению Пользователь и Агрегатор несут ответственность в
        соответствии с законодательством Российской Федерации с учетом условий
        Соглашения.
        </p>
        <p dir="ltr">
        4.11. ИП Лекан Александра Владимировна не осуществляет рассмотрение и
        удовлетворение претензий Пользователей в отношении работ/услуг, оказываемых
        Исполнителями. При обращении Пользователя к Агрегатору по вопросам,
        касающимся Договора, заключаемого в результате оформления Заказа, в том
        числе с претензиями относительно исполнения данного Договора, Агрегатор
        вправе передать соответствующую информацию Исполнителю, а также передать
        Пользователю информацию, полученную от Исполнителя по данным вопросам.
        </p>
        <p dir="ltr">
        4.12. Агрегатор не несет ответственность за содержание и/или актуальность
        информации, предоставляемой Исполнителем о Товаре и/или Услуге, включая
        информацию о стоимости Товара или Услуги, сроках приготовления Товара и его
        выдачи, а также наличии заказанного блюда в данный момент.
        </p>
        <p dir="ltr">
        4.13. Агрегатор не несет ответственности за посещение и использование им
        внешних ресурсов, ссылки на которые могут содержаться в мобильном
        приложении.
        </p>
        <p dir="ltr">
        4.14. Пользователь согласен с тем, что Агрегатор не несет какой-либо
        ответственности и не имеет каких-либо обязательств в связи с рекламой,
        которая может быть размещена в Мобильном Приложении.
        </p>
        <p dir="ltr">
        5. ПРОЧИЕ УСЛОВИЯ
        </p>
        <p dir="ltr">
        5.1. Пользователь подтверждает, что он является дееспособным и достиг
        возраста, необходимого в соответствии с законодательством Российской
        Федерации для заключения Договоров с Исполнителем, а также для совершения
        иных сделок, предусмотренных Пользовательским соглашением.
        </p>
        <p dir="ltr">
        5.2. Порядок обращения Пользователя к Агрегатору: все обращения должны
        направляться на адрес электронной почты    <a href="mailto:jocforusers@gmail.com">jocforusers@gmail.com</a>, либо по
        адресу для переписки, указанному ниже. Функционалом Сервиса также могут
        быть предусмотрены иные способы направления Пользователем обращений к
        Агрегатору.
        </p>
        <p dir="ltr">
        5.3. Все возможные споры, вытекающие из настоящего Соглашения или связанные
        с ним, подлежат разрешению в соответствии с действующим законодательством
        Российской Федерации.
        </p>
        <p dir="ltr">
        5.4. Признание судом какого-либо положения Соглашения недействительным или
        не подлежащим принудительному исполнению не влечет недействительности иных
        положений Соглашения.
        </p>
        <p dir="ltr">
        5.5. Бездействие со стороны Агрегатора в случае нарушения кем-либо из
        Пользователей положений Соглашения не лишает Агрегатора права предпринять
        позднее соответствующие действия в защиту своих интересов.
        </p>
        <p dir="ltr">
        6. РЕКВИЗИТЫ АГРЕГАТОРА
        </p>
        <div dir="ltr" align="left">
        <table>
        <colgroup>
        <col width="623"/>
        </colgroup>
        <tbody>
        <tr>
        <td>
        <p dir="ltr">
        ИП Лекан Александра Владимировна
        </p>
        <p dir="ltr">
        ОГРНИП: 320745600066981
        </p>
        <p dir="ltr">
        ИНН: 022003572411
        </p>
        <p dir="ltr">
        Реквизиты АО "АЛЬФА-БАНК"
        </p>
        <p dir="ltr">
        БИК: 044525593
        </p>
        <p dir="ltr">
        К/с: 30101810200000000593 в ГУ БАНКА РОССИИ ПО ЦФО
        </p>
        <p dir="ltr">
        Телефон: +7 916 347-68-27
        </p>
        <p dir="ltr">
        e-mail: jocforpartners@gmail.com
        </p>
        </td>
        </tr>
        </tbody>
        </table>
        </div>
        <br/>
        """
    }
    
    static func getImageExample()->String
    {
        return "data:image/jpeg;base64,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"
    }
}
