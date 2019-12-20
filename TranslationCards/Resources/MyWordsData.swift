//
//  MyWordsData.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 18.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

struct MyWordsData {
    
    var words: [(String,String)]
    var name: String
    
    static let pastNotRightPhorm: [(String, String)] = [
        ("Он сделал мне одолжение.", "He did me a favor."),
        
        ("Сделал", "Make - made - made"),
        
        ("Он сделал открытие.", "He made a discovery."),
        
        ("Быть", "Be, was - he, she, it, were"),
        
        
        ("Я был горько разочарован.", "I was bitterly disappointed."),
        
        ("Это был огромный(громадный) успех.", "It was a huge(tremendous) success."),
        
        
        ("Идти", "Go - went - gone"),
        
        ("Он пошел на работу.", "He went to work."),
        
        
        ("Могу", "Can - could"),
        
        ("Я мог учить англ часами.", "I could learn English for hours."),
        
        ("Он мог обьяснять очень сложные слова используя простые слова.", "He could explain very difficult words using simple words."),
        
        
        ("Я мог слушать ее делая другие вещи.", "I could listen to her doing other things."),
        
        ("Получать", "Get - got - got"),
        
        ("Я получил емэйл от нее.", "I got an email from her."),
        
        ("Знать", "Know- knew - known"),
        
        ("Мы знали это в начале.", "We knew it in the beginning."),
        
        ("Сказать -", "Say - said - said"),
        
        ("Он сказал это тихо/громко", "He said it quietly/ loudly"),
        
        ("Сказать кому то", "Tell - told - told"),
        
        ("Он сказал мне все.", "He told me everything."),
        
        ("Думать", "Think - though- though"),
        
        ("Я тоже думал так.", "I also thought so."),
        
        ("Я думал по другому.", "I thought differently."),
        
        ("Чувствовать", "Feel - felt - felt"),
        
        ("Она чувствовала себя расстроеной.", "She felt upset."),
        
        ("Становиться", "Become - became - become"),
        
        ("Ставить", "Put - put - put"),
        
        ("Находить", "Find - found - found"),
        
        ("Я нашел свой бумажник.", "I found my wallet."),
        
        ("Выяснять", "Found out"),
        
        ("Давать", "Give - gave - given"),
        
        ("Он бросил курить.", "He gave up smoking."),
        
        ("Значит.", "Mean - meant - meant."),
        
        ("Это значило следущее.", "It meant the following."),
        
        ("Намереваться что то делать.", "Mean to do something."),
        
        ("Он намеревался помочь мне.", "He meant to help me."),
        
        ("Начинаться.", "Begin - began - begun."),
        
        ("Урок начался вовремя.", "The lesson began on time."),
        
        ("Встреча началась на много позже.", "The meeting began much later."),
        
        
        ("Показывать.", "Show - showed - shown."),
        
        ("Он показал блестящие результаты.", "He showed brilliant results."),
        
        ("Мальчик показал выдающиеся результаты.", "The boy showed the outstanding results."),
        
        ("Урок начался два часа назад(пол часа назад).", "The lesson began two hours ago. (half an hour ago)"),
        
        ("Позволять.", "Let - let - let."),
        
        ("Позволить кому то что то сделать.", "Let somebody do something."),
        
        ("Покидать.", "Leave - left - left."),
        
        ("Мы покинули англию.", "We left England."),
        
        ("Поехал в", "Left for."),
        
        ("Я поехал в Россию.", "I left for Russia."),
        
        ("Я уехал с России.", "I left Russia."),
        
        ("Услышать.", "Hear - heard - heard."),
        
        ("Я услышал это по радио.", "I heard it on the radio."),
        
        ("Я услышал это в новостях.", "I heard it in the news."),
        
        ("Я услышал это в первые.", "I heard it for the first time."),
        
        ("Бежать.", "Run - ran - run."),
        
        ("Он побежала очень быстро.", "She ran very fast."),
        
        ("Он убежал.", "He ran away."),
        
        ("Приносить.", "Bring - brought- brought."),
        
        ("Он принес эту вещь мне.", "He brought this thing to me."),
        
        ("Он дал эту вещь.", "He gave this thing."),
        
        ("Писать.", "Write - wrote - written."),
        
        ("Он написал такую интересную книгу.", "He wrote such an interesting book."),
        
        ("Я записал это.", "I wrote it down."),
        
        ("Я записал это слово.", "I wrote this word down. I wrote down this word."),
        
        ("Намеревался(две формы)", "Meant & intended"),
        
        ("Читать", "Read - read - read (Рид - рэд - рэд)"),
        
        ("Сидеть", "Sit - sat - sat"),
        
        ("Я сел на стул.", "I sat on a chair."),
        
        ("Я сел в кресло.", "I sat in a armchair."),
        
        ("Я присел.", "I sat down."),
        
        ("Встать.", "Stand - stood - stood"),
        
        ("Я встал.", "I stood up."),
        
        ("Я стал позади его.", "I stood behind him."),
        
        ("Терять", "Lose lost lost"),
        
        ("Она потерял свои ключи.", "She lost her keys."),
        
        ("Платить", "Pay paid paid"),
        
        ("Я заплатил за нее", "I paid for her."),
        
        ("Я заплатил за эту услугу", "I paid for this service"),
        
        ("Встречать", "Meet - met - met"),
        
        ("Они встретились на конец", "They met at last."),
        
        ("Я встретил моего одноклассника вчера.", "I met my classmate yesterday."),
        
        ("Поставил, установил", "Set set set"),
        
        ("Он поставил стакан воды на стол.", "He set a glass of water on the table."),
        
        ("Основал очень прибыльную компанию.", "He set up a very profitable company."),
        
        ("Учить", "Learn learnt learnt Learned learned"),
        
        ("Я выучил текст наизусть.", "I learnt text by heart."),
        
        ("Понимать -", "understand - understood - understood"),
        
        ("Я понял тебя сразу.", "I understood you immediately / at once."),
        
        ("Резать", "Cut - cut - cut"),
        
        ("Он порезался", "He cut himself"),
        
        ("Он порезал мясо на 4 части(кусочка)", "He cut the meat into for parts. (pieces)"),
        
        ("Продовать", "Sell sold sold"),
        
        ("Они продали свой загородный дом за 50 дол.", "They sold their country house for 50 dollars"),
        
        ("Тратить", "Spend spent spent"),
        
        ("Я потратил 700 дол на это.", "I spent 700 dol on it."),
        
        ("Расти, выращивать", "Grow grew grown"),
        
        ("Она выращивала фрукт и овлщи в своем собственном саду.", "She grew fruit and vegetables in her own garden."),
        
        ("Я вырос в америкe.", "I grew up in america."),
        
        ("Я вырос в маленьком городке.", "I grew up in a small town."),
        
        ("Выигрывать", "Win won won"),
        
        ("Мы выиграли в том соревновании.", "We won in that competition."),
        
        ("Купить", "Buy bought bought"),
        
        ("Она купила очень просторную квартиру.", "She bought a very spacious flat."),
        
        ("Отправлять", "Send sent sent"),
        
        ("Она отправила мне сообщение", "She sent me a message"),
        
        ("Падать", "Fall fell fallen"),
        
        ("Ушибить(ушибся)", "Hurt hurt hurt"),
        
        ("Он упал на землю и ушиб свою руку.", "He fell on a ground (He fell down) and hurt his arm."),
        
        ("Хранить", "Keep kept kept"),
        
        ("Он сохранил этот секрет.", "He kept this secret."),
        
        ("Он сдержал свое слово.", "He kept his word."),
        
        ("Держать(руками например)", "Hold held held"),
        
        ("Я подержал ее сумку.", "I held her bag."),
        
        ("Ломать", "Break broke broken"),
        
        ("Они разбили окно.", "They broke the window."),
        
        ("Его машина сломалась.", "His car broke down."),
        
        ("Ловить", "Catch - caught caught"),
        
        ("Мы ловили рыбу", "We caught  fish"),
        
        ("Полиция поймала вора", "The police caught the thief."),
        
        ("Рисовать", "Draw drew drawn"),
        
        ("Он нарисовал шедевр", "He drew a masterpiece"),
        
        ("Драться", "Fight fought fought"),
        
        ("Они сражались очень смело", "They fought very bravely"),
        
        ("Этот солдат сражался очень отважно.", "This solder fought  very courageous."),
        
        ("Иметь дело", "Deal dealt dealt"),
        
        ("Я имел дело с поставщиками", "I dealt with suppliers"),
        
        ("Бросать", "Throw threw thrown"),
        
        ("Он бросил в нее камень", "He threw a stone at her"),
        
        ("Я выбросил это", "I threw it away"),
        
        ("Носить", "Wear wore worn"),
        
        ("Она носила очень дорогую одежду", "She wore very expensive close"),
        
        ("Я носил ремень", "I wore a belt"),
        
        ("Учить", "Teach taught taught"),
        
        ("Я поеподовал англ", "I taught English"),
        
        ("Он преподал мне урок", "He taught me a lesson"),
        
        ("Лежать", "Lie lay lain"),
        
        ("Я прилег", "I lay down"),
        
        ("Я полежал в кровати", "I lay in bed"),
        
        ("Лгать", "Lie lied lied"),
        
        ("Она солгала мне", "She lied to me"),
        
        ("Поставить", "Lay laid laid(set, put)"),
        
        ("Я поставил это на стол", "I laid it on the table."),
        
        ("Летать", "Fly flew flown"),
        
        ("Я полетел в америку", "I flew to america"),
        
        ("Я полетел назад в зп", "I flew back to ZP"),
        
        ("Петь", "Sing sang sung"),
        
        ("Она пела очень красиво.", "She sang very beautiful."),
        
        ("Спать", "Sleep slept slept"),
        
        ("Я поспал достаточно.", "I slept enough."),
        
        ("Я обычно спал около 8 часов.", "I usually slept for about 8 hours."),
        
        ("Я поспал 10 часов.", "I slept for 10 hours."),
        
        ("Забывать", "Forget forgot forgotten"),
        
        ("Я забыл эту вещь полностью.", "I forgot this thing completely."),
        
        ("Я забыл позвонить ей.", "I forgot to call her."),
        
        ("Ударить", "Hit hit hit"),
        
        ("Он ударил по мячу.", "He hit the ball."),
        
        ("Они ударили его очень сильно.", "They hit him very hard / badly."),
        
        ("Есть", "Eat ate eaten"),
        
        ("Я ел это на завтрак.", "I ate it for breakfast."),
        
        ("Он сьел бутерброд.", "He ate a sandwich."),
        
        ("Пить", "Drink drank drunk"),
        
        ("Он выпил стакан воды.", "He drank a glass of water."),
        
        ("Он выпил стакан вина.", "He drank a glass of wine."),
        
        ("Прятаться", "Hide hid hidden"),
        
        ("Он спрятался за тем зданием.", "He hid behind that building."),
        
        ("Кататься", "Ride rode ridden"),
        
        ("Я катался на лошаде.", "I rode a horse."),
        
        ("Кормить", "Feed fed fed"),
        
        ("Она покормила кота.", "She fed the cat."),
        
        ("Она покормила своего малыша.", "She fed her baby."),
        
        ("Подходить", "Fit fit fit"),
        
        ("Эта пара обуви подошла мне.", "This pair of shoes fit me."),
        
        ("Преодолевать", "Overcome - overcame - overcome"),
        
        ("Мы преодолели те трудности", "We overcame those difficulties."),
        
        ("Плавать", "Swim swam swum"),
        
        ("Я плавал в бассейне.", "I swam in the swimming pool."),
        
        ("Я плавал в озере.", "I swam in the lake."),
        
        ("Я плавал в пруду.", "I swam in the pond."),
        
        ("Одалживать.", "Lend lent lent"),
        
        ("Я одолжил ему эту сумму дененг.", "I lent him this sum of many."),
        
        ("Дуть", "Blow blew blown"),
        
        ("Ветер вдруг подул.", "The wind blew suddenly."),
        
        ("Ушибить, задеть", "Hurt hurt hurt (injured правильная форма)"),
        
        ("Она ушибла руку", "She hurt her arm"),
        
        ("Он задел ее чувства.", "He hurt her feelings."),
        
        ("Мечтать", "Dream - dreamt - dreamt(может быть правильным dreamed)"),
        
        ("Я мечтал о различных вещах.", "I dreamt about different things."),
        
        ("Она мечтала о карьере в музыке.", "She dreamt about a career in music."),
        
        ("Воровать", "Steal stole stolen"),
        
        ("Он украл ее сумку.", "He stole her bag."),
        
        ("Он украл ювелир украш.", "He stole jewelry."),
        
        ("Просыпаться", "Wake woke woken"),
        
        ("Я проснулся раньше чем обычно.", "I woke up early/later than usually."),
        
        ("Капать", "Dig dug dug"),
        
        ("Он вырыл яму", "He dug a hole"),
        
        ("Прощать", "Forgive forgave forgiven"),
        
        ("Я простил ее", "I forgave her"),
        
        ("Она простила все", "She forgave everything")
    ]
    
    static let pastTime: [(String, String)] = [
        ("Я желаю вам большого успеха. Я чувствую вы этого заслуживаете.", "I wish you a huge success.  I feel you deserve it."),
        
        ("Я пользовался интернетом практически каждый день.", "I used the internet almost every day."),
        
        ("Мне нужно было связаться с ней.", "I needed to get in touch with her."),
        
        ("Она задала ему пару вопросов.", "She asked him a couple of questions."),
        
        ("Он повернулся и улыбнулся ей.", "He turned and smiled at her."),
        
        ("Мы включили его имя.", "We included his name."),
        
        ("Я включил/выключил компьютер.", "I turned on/off the computer. I switched on/off the computer."),
        
        ("Я повторил твои уроки еще раз.", "I revise your lessons one more time."),
        
        ("Мы пошли в парк.", "We walked to the park. We went to the park on foot."),
        
        ("Мы переехали в лондон.", "We moved to London."),
        
        ("Они обеспечивали очень хорошие условия.", "They provided very good conditions."),
        
        ("Мы считали это очень важным.", "We considered it very important."),
        
        ("Он вошел в сдание.", "He entered the building."),
        
        ("Они предложили нам что то особенное.", "They offered us something special."),
        
        ("Мы ожидали эти результаты.", "We expected these results."),
        
        ("Я достиг этого результата.", "I reached this result."),
        
        ("Они исчезли вдруг.", "They disappeared suddenly."),
        
        ("Они исчезли неожиданно.", "They disappeared unexpectedly."),
        
        ("Они предложили пойти в кино.", "They suggested going to the cinema."),
        
        ("Все осталось таким же.", "Everything remained the same."),
        
        ("Я остался спокойным.", "I remained calm."),
        
        ("Это требовало больше усилий.", "It required more efforts."),
        
        ("Я решил сделать это.", "I decided to do it."),
        
        ("Они производили очень дорогие товары.", "They produced very expensive goods."),
        
        ("Я ненавидел обсуждать это.", "I hated discussing it."),
        
        ("Мы столкнулись с очень большой проблемой.", "We faced a very big problem."),
        
        ("Она описала эту ситуацию.", "She described this situation."),
        
        ("Он описал ее внешность.", "She described her appearance."),
        
        ("Она частично согласилась со мной.", "She partly agreed with me."),
        
        ("Я ответил на следующие вопросы.", "I answered the following questions."),
        
        ("Она упустила ту возможность.", "She missed that opportunity."),
        
        
        ("Я въехал/выехал туда в 3 часа дня.", "I checked in/out at 3 o'clock in the afternoon."),
        
        ("Он воображал различные вещи.", "He imagined different things."),
        
        ("Он постучал в дверь.", "He knocked at/on the door."),
        
        ("Я пожелал ему удачи.", "I wished him good luck."),
        
        ("Я представил его им.", "I introduced his to them."),
        
        ("Он заработал больше чем 500 долларов.", "He earned more than 500 $"),
        
        ("Он перепрыгнул через забор.", "He jumped over the fence."),
        
        ("Я заполнил эти документы.", "I filled in these documents."),
        
        ("Он настаивал на этом.", "He insisted on it."),
        
        ("Он настоял чтобы сделать это.", "He insisted on doing it."),
        
        ("Он отрицал все обвинения.", "He denied all the accusations."),
        
        ("Они разрушили сдание.", "They destroyed the building."),
        
        ("Он пригласил нас на свое день рождение.", "He invited us to his birthday."),
        
        ("Этот дом принадлежал ей.", "This house belonged to her."),
        
        ("Он приказал солдатам сделать это.", "He ordered the soldiers to do it."),
        
        ("Я склонен был думать так.", "I tented to think so."),
        
        ("Мы склоны были считать это очень важным.", "We tented to consider it very important."),
        
        ("Урок длился 2 часа.", "The lesson lasted for 2 hours."),
        
        ("Это привлекло наше внимание.", "It attracted our attention."),
        
        ("Его речь вдохновила нас.", "His speech inspired us."),
        
        ("Он курил очень редко.", "He smoked very rarely/seldom."),
        
        ("Это событие повлияло на меня.", "This event influenced on me."),
        
        ("Он пересек улицу.", "He crossed the street."),
        
        ("Мы поторопились.", "We hurried up."),
        
        ("Он заслуживал это.", "He deserved it."),
        
        ("Он подтвердил дату нашей встрече.", "He confirmed the date of our meeting."),
        
        ("Мы доверяли ему полностью.", "We trusted him completely."),
        
        ("Я сконцентрировался на этой теме.", "I concentrated on this topic."),
        
        ("Он пожалел об этом.", "He regretted it."),
        
        ("Он испытал так много трудностей.", "He experienced so many difficulties."),
        
        ("Он перебил наш разговор.", "He interrupted our conversation/ talk."),
        
        ("Мы конкурировали с несколькими большими компаниями.", "We competed with several big companies."),
        
        ("Он открыл америку.", "He discovered America."),
        
        ("Я разделил это на 3 части.", "I divided it inti three parts."),
        
        ("Он умыл свое лицо.", "He washed his face."),
        
        ("Она помыла посуду.", "She washed up the dishes."),
        
        ("Я упаковал посылку.", "We packed this parcel."),
        
        ("Я припарковался там.", "I parked there."),
        
        ("Он обычно молился утром.", "He usually prayed in the morning."),
        
        ("Он помолился святым.", "He prayed to saints."),
        
        ("Там часто идет дождь/снег.", "It often rained/snowed there."),
        
        ("Они обьявили его в этом преступлении.", "They accused him of this crime."),
        
        ("Они предложили мне высокооплачиваемую работу.", "They offered me a well-payed job."),
        
        ("Враг атаковал их.", "The enemy attacked them."),
        
        ("Он обещал нам сдержать свое слово.", "He promised us to keep his word."),
        
        ("Мы считали эту победу очень важной.", "We considered this victory very important."),
        
        ("Его поведение казалось очень подозрительным.", "His behave seemed very suspicious."),
        
        ("Они убивали невинных людей.", "They killed innocent people."),
        
        ("Я упомянул это во время нашего разговора.", "I mentioned it during our conversation / talk."),
        
        ("Это привлекло наше внимание сразу же.", "It attracted our attention immediately /  at once."),
        
        ("Мальчики вели себя очень плохо.", "The boys behaved very badly."),
        
        ("Я надеялся получить ту работу.", "I hoped to get that job."),
        
        ("Тот мужчина спас ее жизнь.", "That man saved her life."),
        
        ("Он отрицал свою вину.", "He denied his guilt."),
        
        ("Он приказал защищать их.", "He ordered to defend them."),
        
        ("Мой двоюродный брат пожалел об этом.", "My cousin regretted it."),
        
        ("Его поведение казалось очень подозрительным.", "His behave seemed very suspicious."),
        
        ("Он курил достаточно редко.", "He smoked quiet rarely."),
        
        ("Это изменило мое отношение к ней.", "It change my attitude to her."),
        
        ("Они отпраздновали свою годовщину.", "They celebrated their anniversary."),
        
        ("Она предложила пойти в кино.", "She suggested going to the cinema."),
        
        ("Я часто был не согласен с ними без какой либо причины.", "I often disagreed with them for no reason."),
        
        ("Он подтвердил свое решение.", "He confirmed his decision."),
        
        ("Тщательно", "Thoroughly"),
        
        ("Вор", "Thief"),
        
        ("Предлагать делать что то.", "Suggest doing something."),
        
        ("Это произошло случайно.", "It happened by accident. (accidentally)")
    ]
    
    
    
    
    static let engFuture: [(String, String)] = [
        
        ("Мы минимизируем издержки.", "We will minimize the costs."),
        
        ("Ты устанешь. (Ты станешь уставшим)", "You will get tired."),
        
        ("Я достигну этой цели.", "I'll achieve this aim."),
        
        ("Мы обдумаем это.", "We'll think it over."),
        
        ("Мы будем благодарны тебе за это.", "We'll be grateful to you for it."),
        
        ("Мы сэкономим деньги.", "We'll save money."),
        
        ("У них будет выбор.", "They will have a choice."),
        
        ("Он жениться на ней.", "He will marry her."),
        
        ("Он починит это.", "He'll repair it."),
        
        ("Она последует твоему совету.", "She'll follow your advice."),
        
        ("Это удивит тебя очень сильно.", "It'll surprise you greatly."),
        
        ("Это произойдет рано или поздно.", "It'll happen sooner or later."),
        
        ("Я думаю нам не нужно изобретать заново колесо.", "I think we don't need to reinvent the wheel."),
        
        
        ("Наш менеджер по продажам посчитает это.", "Our sale manager will calculate it."),
        
        ("Учитель простит им.", "The teacher will forgive him."),
        
        ("Мы с другом поторопимся.", "My friend and i will hurry up."),
        
        ("Мой бизнес партнер отдолжит ему эту сумму денег.", "My business partner will lend him this sum of money."),
        
        ("Его друг займет эти деньги.", "His friend will borrow this money."),
        
        ("Власти будут регулировать это как то.", "The authorities will regulate it somehow."),
        
        ("Мы с моим другом будем уделять английскому/здоровью больше свободного времени.", "My friend and i will devote more free time to English/ health."),
        
        ("Люди часто путают эти слова.", "People often confuse/(mix up) these words."),
        
        ("Его бизнес партнер пожалеет об этом.", "His business partner will regret it."),
        
        ("Эти меры будут стимулировать наши продажи.", "These measures will stimulate our sales."),
        
        ("Этих знаний будет больше чем достаточно.", "This knowledge will be more than enough."),
        
        ("Жизнь накажет его.", "Life will punish him."),
        
        ("Жизнь преподаст ему рок.", "Life will teach him a lesson."),
        
        ("Ты не сдашь этот экзамен без подготовки.", "You won't pass the exam without preparation."),
        
        ("Они не найдут решение этой проблеме.", "They won't find a solution to this problem."),
        
        ("Это не приведет к успеху.", "It won't lead to success."),
        
        ("Я не буду перебивать его.", "I won't interrupt him."),
        
        ("Я не буду принимать участия в этом соревновании.", "I won't take part in this competition. (participate)"),
        
        
        ("Мы не будем конкурировать с этой компанией.", "We won't compete with this company."),
        
        ("Мы не будем жаловаться об этом.", "We won't complain about it."),
        
        ("Ты не повлияешь на него.", "You won't influence him."),
        
        ("Он не будет курить больше.(дольше)", "He won’t smoke anymore.(any longer)"),
        
        ("Она не будет отрицать этот факт.", "She won’t deny this fact."),
        
        ("Это будет не законно.", "It won’t be legal. (It’ll be illegal)"),
        
        ("Она не будет реагировать на это.", "She won’t react to it."),
        
        ("Мой босс не будет настраиваться на это.", "My boss won't insist on it."),
        
        ("Мои коллеги не поддержат инициативу.", "My colleges won't support this initiative."),
        
        ("Мальчик не выучить это за один день.", "The boy won't learn it in one day."),
        
        ("Гости не заметят наше отсутствие.", "The guests won't notice our absence. (absent - отсутствует, present - присутствует)"),
        
        ("Этот подход не будет достаточно инновационным.", "This approach won't be innovative enough."),
        
        ("Это поменяет мое отношение к этой проблеме?", "Will it change my attitude to/towards this problem?"),
        
        ("Ты укажешь на мои ошибки?", "Will you point at my mistakes?"),
        
        ("Это будет длиться вечно?", "Will it last forever?"),
        
        ("Это будет длиться больше двух часов?", "Will it last for more than two hours?"),
        
        
        ("Это будет длиться около двух часов?", "Will it last for about two hours?"),
        
        ("Послезавтра", "The day after tomorrow"),
        
        ("Ты будешь скучать по ней?", "Will you miss her?"),
        
        ("Ты будешь доступен завтрашним утром?", "Will you be available tomorrow morning?"),
        
        ("Стемнеет скоро?", "Will it get dark soon?"),
        
        ("Необходимо будет подписать отчет?", "Will it be necessary to sign the report?"),
        
        ("Это будет потенциальная угроза?", "Will it be a potential threat?"),
        
        ("Ты будешь интересоваться этим?", "Will you be interested in it?"),
        
        ("Ты пропустишь этот автобус?", "Will you miss this bus?"),
        
        ("Все будут расстроенные.", "Everyone will be disappointed"),
        
        ("Директор упомянет это позже?", "Will the director mention it later."),
        
        ("Мое произношение будет намного лучше?", "Will my pronunciation be much better?"),
        
        ("Студент отгадает правильный ответ?", "Will the student guess the correct answer?"),
        
        ("Студенты посмотрят это в словаре?", "Will the students look it up in a dictionary?"),
        
        ("Этот результат впечатлит их?", "Will this result impress them?"),
        
        ("Этот мальчик сдаст наконец экзамен?", "Will this boy pass the exam at last?"),
        
        ("Девочка завалит этот экзамен?", "Will the girl fail this exam?"),
        
        ("Все выразят свою точку зрения?", "Will everyone express their point of view?"),
        
        ("Все выразят неудовлетворенность текущей ситуацией?", "Will everyone express their dissatisfaction of the current situation?"),
        
        ("Когда она присоединится к нам?", "When will she join us."),
        
        ("Как они смогут решить проблему?", "How will they be able to solve this problem?"),
        
        ("Мог - сможешь - смогу в будущ.", "Could - can - will be able."),
        
        ("Я сумею сделать что то. Я сумею сделать это.", "I'll manage to do something. I'll manage to do it."),
        
        ("Как ты сумеешь решить эту проблему.", "How will you manage to solve this problem."),
        
        ("Что будет принадлежать ему?", "What will belong to him."),
        
        ("Сколько времени ты потратишь на это?", "How much time will you spend on it?"),
        
        ("Сколько денег ты потратишь на это?", "How much money will spend on it?"),
        
        ("Где будет проходить конференция?", "Where will the conference take place?"),
        
        ("Какие каналы твои друзья будут смотреть на регулярной основе?", "Which channels will your friends watch on a regular basis?"),
        
        ("Сколько денег ее муж будет должен им?", "How much money will her husband owe them?"),
        
        ("Как долго твои родители будут отсутствовать?", "How long will your parents be away?"),
        
        ("Его нет дома.", "He is out."),
        
        ("Он отсутствует.", "He is away."),
        
        ("Это не принесет тебе больше денег.", "It won't bring you more money."),
        
        ("Эти условия подойдут нам.", "This conditions will suit us."),
        
        ("Он скоро женится.", "He will get married soon."),
        
        ("Они скоро разведутся?", "Will they get divorced soon?"),
        
        ("Это будет стандартная процедура?", "Will it be a standard procedure?(просиджи)"),
        
        ("Она сохранит этот секрет.", "She will keep this secret."),
        
        ("Они не смогут разрешить этот конфликт.", "They won't be able to resolve this conflict."),
        
        ("Они будут вести себя более осторожнее.", "They'll behave more carefully."),
        
        ("Необходимо будет проверить это более тщательно.", "It'll be necessary to check it more thoroughly."),
        
        ("Я заработаю 500 долларов.", "I'll earn 500 dollars."),
        
        ("Они смогут найти это везде.", "They'll be able to find it everywhere."),
        
        ("Они будут есть свежие овощи и фрукты.", "They will eat fresh fruit and vegetables."),
        
        ("Дешево", "Cheaply"),
        
        ("Это будет нашим достижением.", "It'll be our achievement."),
        
        ("Он отправит ему такое важное письмо.", "He'll send him such an important letter."),
        
        
        
        ("Я буду гордится вашими результатами.", "I will be proud of your results."),
        
        ("Я думаю он будет обожать спорт, но это не обязательно означает, что он станет профессиональным спортсменом.", "I think he'll fond of sport but it doesn't necessarily mean that he'll became a professional sportsman."),
        
        ("В чем причина этого?", "What is the reason for it?"),
        
        ("Я смогу улучшить свой английский очень сильно(значительно).", "I will be able to improve my english greatly(significantly, considerably)"),
        
        ("Я сумею удвоить наши продажи, не смотря на кризис.", "I'll manage to double our sales, despite (in spite of) the crisis."),
        
        ("И так далее.", "And so on. (etc. - et cetera)"),
        
        ("Этот канал поможет вам выучить английский бесплатно.", "This channel will help you learn English for free."),
        
        ("Я постараюсь не делать это.", "I'll try not to do it."),
        
        ("Я постараюсь не упоминать это.", "I'll try not to mention it."),
        
        ("Большой / огромный успех.", "Big /(huge, tremendous) success."),
        
        ("Настаивать на этом.", "Insist on it."),
        
        ("Неудобный.", "Inconvenient."),
        
        ("Принимать серьезные меры.", "Take serious measures."),
        
        ("Привести к успеху.", "Lead to success."),
        
        ("Тебе повезет.", "You'll be lucky."),
        
        ("Мне кажется день не будет дождливым.", "It seems to me the day won't be rainy.")
    ]
    
    
    static let english2: [(String, String)] = [
        ("Это ее страсть?" , "Is it her passion?"),
        
        ("Она рада видеть его." , "She is glad to see him."),
        
        ("Они часто смеются над этим/ над ним" , "They often laugh at it/ at him"),
        
        ("Я получаю удвольствие от анг / спорта" , "I enjoy english / sport"),
        
        ("Я обожаю иностранные языки." , "I enjoy foreign languages."),
        
        ("Он музыкант." , "He is musician."),
        
        ("Это потеря времени / денег" , "It's a waste of time / money"),
        
        ("Это комфортно для меня." , "It's comfortable for me.(если время то convenience)"),
        
        
        ("Это мое окончательное решение." , "It's my final decision. I"),
        
        ("Это необходимо." , "It's necessary."),
        
        ("Это естественно" , "It's natural"),
        
        ("Это на полу" , "It's on the floor"),
        
        ("Это наш последний шанс." , "It's our last chance. (чанс)"),
        
        ("Наш учитель часто сравнивает наши результаты." , "Out teacher often compares our results."),
        
        ("Этот звук очень громкий/ тихий" , "This sound is very loud / quiet"),
        
        ("Мне надо адаптироваться к этим условиям." , "I need to adapt to these conditions."),
        
        ("Он не больной." , "He isn't ill."),
        
        ("Болезнь." , "Illness"),
        
        ("Она не дружелюбная/толстая" , "She isn't friendly/fat"),
        
        ("Это не удивительно." , "It isn't surprising."),
        
        ("Это кресло/стул удобное для меня." , "This armchair/chair is comfortable for me."),
        
        ("Презентация не ясная." , "The presentation isn't clear."),
        
        ("Его жена не ходит за покупками так часто." , "His wife doesn't go shopping so often."),
        
        ("Моя сестра не общается с ним." , "My sister doesn't communicate with him."),
        
        ("Я хотел бы общаться с людьми из других стран." , "I'd like to communicate with people from other(для множительного числа) countries."),
        
        ("Мне не нравится эта мебель." , "I don't like this furniture (фенече)"),
        
        ("Мне не нравится реклама." , "I don't like advertising. (адветайзин)"),
        
        ("Мне не нравится эта реклама." , "I don't like this advertisement."),
        
        (" Мы рядом с этим местом?" , "Are we near this place? (Без артикля!!)"),
        
        ("Они часто разговаривают про это?" , "Do they often talk about it?"),
        
        ("Он соревнуется с ними?" , "Does he compete with them?"),
        
        ("Его партнер тратит слишком много денег?" , "Does his partner spend too much money?"),
        
        ("Его поведение не обычное?" , "Is his behavior unusual?"),
        
        ("Его брат ведет себя странно?" , "Does his brother behave strangely?"),
        
        ("Сумка дорогая?" , "Is the bag expensive?"),
        
        ("Твоя сестра одна сейчас?" , "Is your sister alone now?"),
        
        ("Моего опыта достаточно?" , "Is my experience enough?"),
        
        ("Я надеюсь ты помнишь это!" , "I hope you remember it."),
        
        ("Этот мальчик его старший/младший брат?" , "Is this boy his elder/younger brother?"),
        
        ("Еда вкусная/очень вкусная?" , "Is the food tasty/delicious?"),
        
        ("Все студенты знают значение этого слова?" , "Do all the students know the meaning of this word?"),
        
        ("Тебе надо закончить это к завтрешнему?" , "Do you need to finish it by tomorrow?"),
        
        ("Вы знаете друг друга." , "You know each other."),
        
        ("Они живут раздельно." , "They live separately."),
        
        ("Я интересуюсь этим." , "I am interested in it."),
        
        ("Я увлекаюсь музыкой/чтением." , "I am keen on music/reading."),
        
        ("Это интересует его." , "It interests him."),
        
        ("Как ты обычно празднуешь свое день рождение?" , "How do you usually celebrate your birthday."),
        
        ("Как он готовиться к своим экзаменам." , "How does he prepare for his exams."),
        
        ("Что он пытается делать чтобы изменить это?" , "What does he try to do to change it."),
        
        ("Я обожаю этот канал благодаря нашему учителю." , "I am fond of this channel thanks to our teacher."),
        
        ("Благодаря ясным обьяснениям." , "Thanks to clear explanations."),
        
        ("Что пугает тебя?" , "What frightens you?"),
        
        ("Каким видео ты восхищаешься больше?" , "Which video do you admire more."),
        
        ("Какие каналы популярные в наши дни?" , "What channels are popular nowadays?"),
        
        ("Я прекрасно понимаю тебя." , "I perfectly understand you."),
        
        ("Я прекрасно осознаю это." , "I perfectly realize it."),
        
        ("Мне следует делать это." , "I should do it."),
        
        ("Я возможно это сделаю." , "I may/might do it."),
        
        ("Я обожаю смотреть этот канал." , "I enjoy watching the channel."),
        
        ("Я люблю смотреть этот канал(как случай)" , "I like watching the channel."),
        
        ("Вежливый/ невежливый" , "Polite/ impolite"),
        
        ("Взрослый мальчик." , "Adult(grown-up) boy"),
        
        ("Толстый - худой / стройный" , "Fat - thin / slim"),
        
        ("Покупать - продавать" , "Buy - sell"),
        
        ("Забывать, помнить" , "Forget - remember"),
        ("Женат - холост, разведен" , "Married - single, divorced"),
        
        ("Смеяться - плакать(кричать)" , "Laugh - cry"),
        
        ("Давать - брать" , "Give - take"),
        
        ("Низкий - высокий, высокий человек." , "Low - high, a tall man."),
        
        ("Доверять мне" , "Trust me"),
        
        ("Аморальный - моральный" , "Immoral - moral"),
        
        ("Простота" , "Simplicity"),
        
        ("Грубый" , "Rude"),
        
        ("Значение этой фразы не ясно." , "The meaning of this phrase is not clear for me."),
    ]
    
    
    
    
    
    
    
    
    
    static let english1: [(String,String)] =
        [
            ("утверждать", "Assert"),
            
            ("Описание", "Describing"),
            
            ("пустышка, маникен", "Dummy"),
            
            ("заглушка", "stub"),
            
            ("шпион", "spy"),
            
            ("макет", "mock"),
            
            ("потомок", "Descendant"),
            
            ("привлекать", "Attract"),
            
            ("согласен", "Agree."),
            
            ("решить эту проблему", "To solve this problem"),
            
            ("Решать", "Solve."),
            
            ("исправить эти ошибки", "To correct these mistakes"),
            
            ("Правило", "Rule"),
            
            ("Улучшить", "Improve"),
            
            ("прибыль", "Profit."),
            
            ("Вовсе", "At all."),
            
            ("Совет", "Advice"),
            
            ("время от времени", "From time to time"),
            
            ("Обьяснять", "Explain"),
            
            ("как можно скорее", "As soon as possible -"),
            
            ("Отдыхать", "Have a rest"),
            
            ("Это мое Решение", "It my Decision"),
            
            ("ненавидить эти вещи", "Hate these things"),
            
            ("Слушать радио", "Listen to the radio"),
            
            ("Это кажется скучным?", "Does it seem boring?"),
            
            ("Этот экзамен кажется очень сложным?", "Does this exam seem very difficult?"),
            
            ("Вся правда", "All the truth"),
            
            ("Блестящий результат", "Brilliant result"),
            
            ("Зависит от тебя", "Depends on you"),
            
            ("Проводить время", "Spend time"),
            
            
            ("Добираться на работу", "Get to work"),
            
            ("Добираться до туда/сюда/домой", "Get there/her/home"),
            
            ("Какую музыку ты предпочитаешь?", "What music do you prefer?"),
            
            ("Какого рода книг ты читаешь?", "What kind of books do you read?"),
            
            ("Во сколько ты ложишься спать?", "What time do you go to bed?"),
            
            ("Как часто ты занимаешься англ?", "How often do you learn english?"),
            
            ("Почему он жалуется так часто?", "Why does he complain so often?"),
            
            ("Отказаться платить", "Refuse to pay"),
            
            ("Снова и снова", "Again and again"),
            
            ("Что беспокоит тебя?", "What worries you?"),
            
            ("Критиковать", "Criticize"),
            
            ("Не соглашаться с тобой", "Disagree with you"),
            
            ("Обещать", "Promise"),
            
            ("Сколько времени у тебя занимает добраться до дома?", "How long does it take you to get home?"),
            
            ("Как регулярно?", "How regularly?"),
            
            ("Что твой босс обычно отвечает?", "What does your boss usually answer?"),
            
            ("Она ходит в школу с большим удовольствием", "She goes to school with great pleasure"),
            
            ("Мы не разделяем твою точку зрения", "We don't share your point of view"),
            
            ("Это не вдохновляет меня", "It doesn't inspire me"),
            
            ("Выполнить запрос (2 вар)", "Execute/perform request"),
            
            ("взаимодействие с пользователем", "User interaction"),
            
            ("следующие специальные символы", "the following special characters"),
            
            ("Заранее спасибо", "Thanks in advance"),
            
            ("Тоже думает так же", "Also think so"),
            
            ("Он часто слышит это", "Does he often hear it"),
            
            ("Почему твой друг хочет искать новую работу", "Why does your friend want to look for a new job"),
            
            ("День ветряный", "The day is windy"),
            
            ("Ты прав", "You're rigth"),
            
            ("Я дома", "I'm at home"),
            
            ("Я на работе", "I'm at work"),
            
            ("Я уверен", "I'm sure/ I'm certain"),
            
            ("Мы в парке", "We're in the park"),
            
            ("Ты очень добрый", "You're very kind"),
            
            ("Они бедные", "They're poor"),
            
            ("Они ленивые", "They're lazy"),
            
            ("Это большой успех", "It's a big success"),
            
            ("Это очень высокий/низкий уровень", "It's a very high/low level"),
            
            ("Это дёшево", "It's cheap"),
            
            ("Тепло", "It's warm"),
            
            ("Жарко", "It's hot"),
            
            ("Дождливо", "It's rainy"),
            
            ("Солнечно", "It's sunny"),
            
            ("Темно", "It's dark"),
            
            ("Это очевидно", "It's obvious"),
            
            ("Это возможно/ не возможно", "It's possible/impossible"),
            
            ("Это с права", "It's on the right"),
            
            ("Это лучше/хуже", "It's better/worse"),
            
            ("Он такой умный", "He's so clever (smart - больше смышленый)"),
            
            ("Он такой талантливый", "He's so talented"),
            
            ("Он такой талантливый человек", "He's such a talented man"),
            
            ("Она такая мудрая женщина", "She's such a wise woman"),
            
            ("Мой бос очень занят сейчас", "My boss is very busy now"),
            
            ("Те уроки не эффективные", "Those lessons are ineffective"),
            
            ("Любовь прекрасное чувство", "Love is a wonderful feeling"),
            
            ("Знание сила", "Knowledge is power"),
            
            ("День ветряный", "The day is windy"),
            
            ("Наш учитель очень трудолюбивый", "Our teacher is very hard-working"),
            
            ("Я не женат", "I'm not married"),
            
            ("Я холостой", "I'm single"),
            
            ("Мы не уставшие", "We aren't tired"),
            
            ("Мы полны энергии", "We are full of energy"),
            
            ("Мы не злые", "We aren't angry"),
            
            ("Ты не прав//", "You aren't right/ you are wrong"),
            
            ("Не успешный(одно слово)", "Unsuccessful"),
            
            ("Я в правильном месте?", "Am i in the right place?"),
            
            ("Я удачливый?", "Am i lucky?"),
            
            ("Мы не в правильном месте?", "Are we in the wrong place?"),
            
            ("Он в здании?", "Is he in the building?"),
            
            ("Это ее мнение?", "Is it her opinion?"),
            
            ("Это его собственная квартира?", "Is it his own flat?"),
            
            ("Для удобства", "For convenience"),
            
            ("Специальное предложение", "Special offer"),
            
            ("Этот бизнес прибыльный?", "Is this business profitable?"),
            
            ("Статья на английском? (Так де значит артикль)" ,"Is the article in English?"),
            
            ("Я конечно", "I  certainly"),
            
            ("Откладывать", "Defer"),
            
            ("Что в твоем кармане?", "What's in your pocket?"),
            
            ("Почему ты против этого?", "Why are you against it?"),
            
            ("Сколько это стоит?", "How much does it cost?"),
            
            ("Где ближайший супермаркет?", "Where is the nearest supermarket?"),
            
            ("Сколько стоят эти брюки?", "How much are these trousers?"),
            
            ("Сколько стоит эта пара брюк?", "How much is this pair of trousers?"),
            
            ("Сколько эти джинсы?", "How much are these jeans?"),
            
            ("Он в командировке", "He's on a business trip"),
            
            ("Это хорошая манера", "It's a good manner"),
            
            ("рукопожатие", "handshake"),
            
            ("возможность", "capability"),
            
            ("Способность", "Ability"),
            
            ("Я не удовлетворен этим решение", "I am not satisfied with this decision"),
            
            ("Это не так", "It's not so"),
            
            ("Они боятся этого?", "Are they afraid of it?"),
            
            ("Это ее страсть?", "Is it her passion?"),
            
            ("Она рада видеть его.", "She is glad to see him."),
            
            ("Они часто смеются над этим/ над ним", "They often laugh at it/ at him"),
            
            ("Я получаю удвольствие от анг / спорта", "I enjoy english / sport"),
            
            ("Я обожаю иностранные языки.", "I enjoy foreign languages."),
            
            ("Он музыкант.", "He is musician."),
            
            ("Это потеря времени / денег", "It's a waste of time / money"),
            
            ("Это комфортно для меня.", "It's comfortable for me."),
            
            ("Это мое окончательное решение.", "It's my final decision."),
            
            ("Это необходимо.", "It's necessary."),
            
            ("Это естественно", "It's natural"),
            
            ("Это на полу", "It's on the floor"),
            
            ("буфер обмена просто пустой", "the clipboard's just empty"),
            
            ("Значек", "Badge"),
            
            ("разрешение получено", "permission granted"),
            
            ("вложение", "attachment"),
            
            ("расписание уведомления", "schedule notification"),
            
            ("получать", "receive"),
            
            ("явный эпл айди", "explicit app id"),
            
            ("Держите ваш доступ до конца вашего текущего членства", "Keep your access until the end of your current membership"),
            
            ("Обмен сообщениями в облаке", "cloud messaging"),
            
            ("Я заболел", "I got sick"),
            
            ("это может быть проблемой?", "could that be the issue?"),
            
            ("взаимодействовать с различными потоками", "interact with various streams"),
            
            ("реактивные привязки", "Reactive Bindings"),
            
            ("привязки модуля представления", "bind view model"),
            
            ("определить ограничения", "Define Constraints"),
            
            ("Требования метода.", "Method requirements.")
    ]
}

