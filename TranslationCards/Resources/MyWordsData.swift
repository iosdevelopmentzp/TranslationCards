//
//  MyWordsData.swift
//  TranslationCards
//
//  Created by Dmytro Vorko on 18.12.2019.
//  Copyright © 2019 Dmytro Vorko. All rights reserved.
//

import Foundation

struct CardsDataSource {
    
    static var cardStrings: [String] { return CardsDataSource.dataSourceLikeString.components(separatedBy: "$")}
    
    private static let dataSourceLikeString = "Грубый%Rude%rus_eng%08D3809B-225C-4701-9FFB-1A803F767773%Eng 2$Она не дружелюбная/толстая%She isn\'t friendly/fat%rus_eng%0A2D7684-14FD-4835-8899-A26113D5631D%Eng 2$Это ее страсть?%Is it her passion?%rus_eng%0A41B3B1-DFBA-4E22-B322-2B6AD2742C00%Eng 2$Это наш последний шанс.%It\'s our last chance. (чанс)%rus_eng%0E2DF674-AED6-4363-8935-93D05C2D105E%Eng 2$Этот звук очень громкий/ тихий%This sound is very loud / quiet%rus_eng%10603885-FD46-4D11-AE95-6B614A8FC9E2%Eng 2$Он музыкант.%He is musician.%rus_eng%11B46222-7571-43C4-AE45-A4EF6C3EF0F0%Eng 2$Он не больной.%He isn\'t ill.%rus_eng%15ABA42B-40BF-41BB-AA41-F1FCD1A275EF%Eng 2$Это мое окончательное решение.%It\'s my final decision.\n%rus_eng%15DAD147-025C-48C8-A45B-40FE2E966DD3%Eng 2$Я надеюсь ты помнишь это!%I hope you remember it.%rus_eng%17E31138-74A0-4FB6-882D-604BCC282BE7%Eng 2$Я прекрасно осознаю это.%I perfectly realize it.%rus_eng%18D4D3E8-520D-4C1F-BDE2-11E5F010A158%Eng 2$Они часто разговаривают про это?%Do they often talk about it?%rus_eng%1D6C539E-96F0-453F-BC1C-5C49F1AD7142%Eng 2$Это комфортно для меня.%It\'s comfortable for me.(если время то convenience)%rus_eng%24061375-4906-4585-9E7D-C28712E3BA9D%Eng 2$Аморальный - моральный%Immoral - moral%rus_eng%24A378B5-868E-469D-822B-3EDC8F4CDC44%Eng 2$Они живут раздельно.%They live separately.%rus_eng%2C0BEF10-FEC1-4968-AC3F-6E0C07DCA3E0%Eng 2$Она рада видеть его.%She is glad to see him.%rus_eng%2D4C4932-710B-4B62-9F2C-48F576371BAF%Eng 2$Я возможно это сделаю.%I may/might do it.%rus_eng%2E06FEFA-36E8-42CA-AFB1-6B04F5F34789%Eng 2$Его брат ведет себя странно?%Does his brother behave strangely?%rus_eng%328A7858-B751-453F-9EFE-ADFBFD5A3AEC%Eng 2$Как он готовиться к своим экзаменам?%How does he prepare for his exams?%rus_eng%3FF571E6-8547-4136-8E22-A9BD7EB90604%Eng 2$Он соревнуется с ними?%Does he compete with them?%rus_eng%43AB3211-D03A-4608-9C30-800EA6438951%Eng 2$Вы знаете друг друга.%You know each other.%rus_eng%4AF110E6-BB47-49AA-B3E8-12A1157863DD%Eng 2$Это на полу%It\'s on the floor%rus_eng%4C6E7150-40B3-463B-B9C9-1855006FAAC0%Eng 2$Я обожаю этот канал благодаря нашему учителю.%I am fond of this channel thanks to our teacher.%rus_eng%5AD35A58-BD6C-4740-8A65-D774CEAD9AE1%Eng 2$Что пугает тебя?%What frightens you?%rus_eng%5B77016E-0723-4D64-963B-87A353A6F098%Eng 2$Это интересует его.%It interests him.%rus_eng%5D1F3176-83E8-4526-AFA4-5B68A2D36178%Eng 2$Тебе надо закончить это к завтрешнему дню?%Do you need to finish it by tomorrow?%rus_eng%62031839-4CF6-49E7-BB91-91D5CE4F8CCF%Eng 2$ Мы рядом с этим местом?%Are we near this place? (Без артикля!!)%rus_eng%666825B1-F107-4B5C-AC16-E338A0162636%Eng 2$Забывать, помнить%Forget - remember%rus_eng%685B04CD-3FD0-447F-BF0C-1B6157C4C019%Eng 2$Женат - холост, разведен%Married - single, divorced%rus_eng%6D2B9FEA-F5BA-49F5-A7C0-57027822560A%Eng 2$Мне надо адаптироваться к этим условиям.%I need to adapt to these conditions.%rus_eng%6FB6C0DB-5786-4233-8207-A1AD49C35107%Eng 2$Доверять мне%Trust me%rus_eng%758E4C6A-8E0A-4732-9D9E-0E5FAC68CD54%Eng 2$Что он пытается делать чтобы изменить это?%What does he try to do to change it?%rus_eng%75CDD4B2-0A6A-4B20-BFDE-93B15FC87A4B%Eng 2$Это потеря времени / денег%It\'s a waste of time / money%rus_eng%7F114BB3-D729-4428-A045-2B5BEFCD2955%Eng 2$Покупать - продавать%Buy - sell%rus_eng%800BEB82-8425-47A3-AD33-580E20D00C93%Eng 2$Я прекрасно понимаю тебя.%I perfectly understand you.%rus_eng%801CFF2A-DF85-4323-B893-A86AD06D4FE6%Eng 2$Это естественно%It\'s natural%rus_eng%8397702A-F5D1-42CA-AA86-3F33BE2DA244%Eng 2$Простота%Simplicity%rus_eng%85B0DEED-3421-4EF9-8390-733F41ECBC01%Eng 2$Значение этой фразы не ясно для меня.%The meaning of this phrase is not clear for me.%rus_eng%85C4DBAC-3D96-461D-94F4-6ED5EB7E7658%Eng 2$Как ты обычно празднуешь свое день рождение?%How do you usually celebrate your birthday?%rus_eng%88E11A02-04B7-44FF-AD55-4FAC4DC0EF81%Eng 2$Его жена не ходит за покупками так часто.%His wife doesn\'t go shopping so often.%rus_eng%895C3542-0F3F-49E7-A68F-7C5F2ADA8DA0%Eng 2$Моя сестра не общается с ним.%My sister doesn\'t communicate with him.%rus_eng%8A4B0421-920F-45C8-B295-C633946F3111%Eng 2$Каким видео ты восхищаешься больше?%Which video do you admire more.%rus_eng%8B3611ED-69BE-4551-A3D4-15D431DD991F%Eng 2$Мне следует делать это.%I should do it.%rus_eng%8F94433B-8D49-4B08-B86B-37081A70DE03%Eng 2$Этот мальчик его старший/младший брат?%Is this boy his elder/younger brother?%rus_eng%91E3133E-34C1-4E73-8C3C-F8ACEDF65A4B%Eng 2$Я обожаю иностранные языки.%I enjoy foreign languages.%rus_eng%922C3E8C-6966-4219-880E-1367619F38F1%Eng 2$Мне не нравится эта мебель.%I don\'t like this furniture (фенече)%rus_eng%989CB1AE-7378-4C40-8D39-A3DB6C581A4A%Eng 2$Какие каналы популярные в наши дни?%What channels are popular nowadays?%rus_eng%9FA603A9-DD12-4169-9A37-6F85AA0F5DD0%Eng 2$Его поведение не обычное?%Is his behavior unusual?%rus_eng%A0206412-AC2F-4870-AAAB-A22D99BB725D%Eng 2$Вежливый/ невежливый%Polite/ impolite%rus_eng%A5AF40E0-6419-4F8F-9EB2-5060905E5069%Eng 2$Я люблю смотреть этот канал(как случай)%I like watching the channel.%rus_eng%A8A404DF-27A1-4573-A558-89F7129E342B%Eng 2$Все студенты знают значение этого слова?%Do all the students know the meaning of this word?%rus_eng%A98955C6-01FA-44C7-B202-654780643233%Eng 2$Мне не нравится эта реклама.%I don\'t like this advertisement.%rus_eng%B2C3934F-F7F1-409B-89BE-DA196798AE18%Eng 2$Это кресло/стул удобное для меня.%This armchair/chair is comfortable for me.%rus_eng%B4CCAE25-74E1-4410-9A3A-39FE6D04B9F6%Eng 2$Болезнь.%Illness.%rus_eng%B7FBACE7-673C-4FC9-BF32-6FDD2EBFFDC6%Eng 2$Твоя сестра одна сейчас?%Is your sister alone now?%rus_eng%BAC3E111-C16F-40E5-A95B-B81A819A12E1%Eng 2$Сумка дорогая?%Is the bag expensive?%rus_eng%BF2CEACC-2BEA-49E2-9B6D-BA6EA14AFF98%Eng 2$Еда вкусная/очень вкусная?%Is the food tasty/delicious?%rus_eng%C7D75F0A-6479-4244-99A8-EDDD913C522B%Eng 2$Я хотел бы общаться с людьми из других стран.%I\'d like to communicate with people from other(для множительного числа) countries.%rus_eng%CB643421-B832-4DFC-BF68-47A81D3EFB9D%Eng 2$Благодаря ясным обьяснениям.%Thanks to clear explanations.%rus_eng%CC08BEF8-EC60-4CCF-B559-C44B0C6E9E75%Eng 2$Презентация не ясная.%The presentation isn\'t clear.%rus_eng%CDAF9936-9EEB-4897-A5AD-D9393417B0D4%Eng 2$Моего опыта достаточно?%Is my experience enough?%rus_eng%D16FC07B-2FB8-4A82-A5D8-26853A0454B3%Eng 2$Наш учитель часто сравнивает наши результаты.%Our teacher often compares our results.%rus_eng%D3B337D6-83F1-4606-8678-455435C3BABA%Eng 2$Взрослый мальчик.%Adult(grown-up) boy%rus_eng%D62C89C4-4270-405C-8365-48FABC77E56F%Eng 2$Это необходимо.%It\'s necessary.%rus_eng%D62CD3D1-A223-4575-8916-D17CA655FAFE%Eng 2$Я интересуюсь этим.%I am interested in it.%rus_eng%D6806120-1398-4022-90E2-24BD39A14A2F%Eng 2$Низкий - высокий, высокий человек.%Low - high, a tall man.%rus_eng%DE86BBDC-77CF-4178-AD4F-81F23D17C760%Eng 2$Смеяться - плакать(кричать)%Laugh - cry%rus_eng%E15F8761-25DB-4A81-9787-6B3940E479AE%Eng 2$Толстый - худой / стройный%Fat - thin / slim%rus_eng%E2210DA5-6496-4FF2-ACE2-D6702447351C%Eng 2$Я получаю удвольствие от анг / спорта%I enjoy english / sport%rus_eng%E63F1C96-D1CA-48EC-A572-C31F07DDFE3E%Eng 2$Я обожаю смотреть этот канал.%I enjoy watching the channel.%rus_eng%E6C79266-A942-4161-8B46-0DE45FD2D575%Eng 2$Я увлекаюсь музыкой/чтением.%I am keen on music/reading.%rus_eng%EACC61B2-9FF0-40E2-8A31-C3401304F5F2%Eng 2$Это не удивительно.%It isn\'t surprising.%rus_eng%ED54DBC0-8235-4386-9196-1AACFA3B0B9E%Eng 2$Давать - брать%Give - take%rus_eng%ED7379A0-6A86-464B-A10E-3850E16D806F%Eng 2$Его партнер тратит слишком много денег?%Does his partner spend too much money?%rus_eng%EF0750FB-96FA-4B0F-A9FC-CC44FA59C807%Eng 2$Мне не нравится реклама.%I don\'t like advertising. (адветайзин)%rus_eng%EF105252-0B92-487C-AE92-78CBCBBB0AE2%Eng 2$Они часто смеются над этим/ над ним%They often laugh at it/ at him%rus_eng%F188C6C5-F66A-401E-89BC-30BCD6B61DFD%Eng 2$Сколько времени у тебя занимает добраться до дома?%How long does it take you to get home?%rus_eng%025C49F3-17B3-4836-8152-96D36E72582A%Eng1$определить ограничения%Define Constraints%rus_eng%0336BC43-61F6-44D4-9DAD-A5BC4F2B1B5D%Eng1$время от времени%From time to time%rus_eng%042F7145-DEFF-46C5-A74C-F6CA51D57E50%Eng1$шпион%spy%rus_eng%07957275-3BA1-4305-B952-C2772908BA7B%Eng1$Этот бизнес прибыльный?%Is this business profitable?%rus_eng%07D27202-7198-47E0-9273-F62D83A5844F%Eng1$Ты очень добрый%You\'re very kind%rus_eng%088E4AA8-62BA-49E3-9750-C076C9526095%Eng1$Мы полны энергии%We are full of energy%rus_eng%098656B2-8EC8-486F-BD48-3DC73DAD118C%Eng1$Где ближайший супермаркет?%Where is the nearest supermarket?%rus_eng%0B125DB8-ABF4-425C-912D-15DD254A5C4E%Eng1$Отказаться платить%Refuse to pay%rus_eng%0B693F01-A6A5-464B-A44A-A5C5F18233A4%Eng1$Это необходимо.%It\'s necessary.%rus_eng%0C63EF01-0A0C-4497-B678-30D8C6CE731A%Eng1$Он такой талантливый%He\'s so talented%rus_eng%0DAD1205-2A3B-46B6-95C2-8218D7146CD5%Eng1$ненавидить эти вещи%Hate these things%rus_eng%0FD403A0-0CFC-44B6-8BD7-4B841F03B177%Eng1$Жарко%It\'s hot%rus_eng%10B44B42-960A-45C0-9872-42430BA76F8C%Eng1$взаимодействие с пользователем%User interaction%rus_eng%10F2A425-D0BA-469D-A562-6518626AF79A%Eng1$пустышка, маникен%Dummy%rus_eng%12A88D94-EF63-40EF-AB98-1419C445EB43%Eng1$Это с права%It\'s on the right%rus_eng%15002AA7-DECC-4A11-AD0D-661DC0F57B13%Eng1$Что беспокоит тебя?%What worries you?%rus_eng%1848D19F-E738-447A-BECA-A55C89269268%Eng1$Мы не уставшие%We aren\'t tired%rus_eng%1A880805-2FAE-4044-9C35-DFD7E8C67612%Eng1$возможность%capability%rus_eng%1B74FA43-F149-4A87-9C96-045354B2BDC2%Eng1$Наш учитель очень трудолюбивый%Our teacher is very hard-working%rus_eng%1C4E6913-4254-4BB3-B9DE-C0CDB355816F%Eng1$Снова и снова%Again and again%rus_eng%1C666042-BFEC-4A08-A984-15E7EC988D85%Eng1$Это дёшево%It\'s cheap%rus_eng%1D42A3CE-E252-45F0-9B3B-822E2C779D4D%Eng1$Проводить время%Spend time%rus_eng%222C8123-78AA-45FA-A2AC-105387807784%Eng1$Описание%Describing%rus_eng%27ABDBD9-8B0C-4ECE-A857-07AE21ED4934%Eng1$Он такой умный%He\'s so clever (smart - больше смышленый)%rus_eng%27CE03D4-C7EF-42AA-8617-BBA44559489E%Eng1$решить эту проблему%To solve this problem%rus_eng%29CB3293-28EB-4E5E-865E-FCD31DAFA859%Eng1$Он такой талантливый человек%He\'s such a talented man%rus_eng%2A5C2940-884A-4E0F-8D7F-68D953722A55%Eng1$Что твой босс обычно отвечает?%What does your boss usually answer?%rus_eng%2C339A6F-2F1A-4FBD-8E08-262DC84B7591%Eng1$Мой бос очень занят сейчас%My boss is very busy now%rus_eng%2CF6EF29-5B7E-4CE9-BA30-62E16E927582%Eng1$Совет%Advice%rus_eng%2F57CB89-9703-45E1-B5ED-E126768EC1B6%Eng1$расписание уведомления%schedule notification%rus_eng%2FBED160-F70A-474D-98F5-886853BBFF2A%Eng1$разрешение получено%permission granted%rus_eng%38046F3B-CAE2-4B83-85D0-EF4BD8F97A99%Eng1$Он музыкант.%He is musician.%rus_eng%383C51FD-A4C3-4B48-8B65-9388BCB02DB8%Eng1$Это на полу%It\'s on the floor%rus_eng%38DCDDD8-E6D0-42C5-B8F8-D3B6B9949D60%Eng1$Она рада видеть его.%She is glad to see him.%rus_eng%38E3C35D-28FD-4ACD-AB10-03FDB32B23DD%Eng1$Вся правда%All the truth%rus_eng%3920208D-1D72-4725-8669-C2BD9D59DA31%Eng1$Это ее страсть?%Is it her passion?%rus_eng%3B071178-4ED3-4600-AB0A-E2EF76CBB674%Eng1$Она ходит в школу с большим удовольствием%She goes to school with great pleasure%rus_eng%3B0CF10C-A3B2-48F7-A6A6-2D3D5EA7532E%Eng1$Сколько это стоит?%How much does it cost?%rus_eng%3C400456-CD56-4DA4-B7EF-52508C122BA3%Eng1$Почему ты против этого?%Why are you against it?%rus_eng%4140F969-6EC7-4225-B120-2B665A5EAAF9%Eng1$Для удобства%For convenience%rus_eng%41519764-F685-4368-BB10-5EEF4FBAF01A%Eng1$Я в правильном месте?%Am i in the right place?%rus_eng%4187B41E-5C99-485E-A9A5-1ECE83D42E12%Eng1$Добираться на работу%Get to work%rus_eng%43D52568-B3D5-4517-83B5-152729C69253%Eng1$Дождливо%It\'s rainy%rus_eng%468F98D2-55E4-4B94-BE76-13D36290D387%Eng1$вложение%attachment%rus_eng%4C03395A-8A1C-4CFE-A0D4-E8B5427F8066%Eng1$утверждать%Assert%rus_eng%4CDF23ED-51A7-4E73-813F-3498E9745CE6%Eng1$следующие специальные символы%the following special characters%rus_eng%4E23C06A-7D95-4493-8AA3-E5768FF71D7E%Eng1$Выполнить запрос (2 вар)%Execute/perform request%rus_eng%50655000-A0CC-4691-B5E2-2A31FE31A84A%Eng1$прибыль%Profit.%rus_eng%514757E4-84B0-4184-BCF6-19E46AECBDC9%Eng1$заглушка%stub%rus_eng%532C131E-E5B1-416E-BB73-1C2633678C58%Eng1$Мы не разделяем твою точку зрения%We don\'t share your point of view%rus_eng%5621C3ED-4F7B-40C0-B5BC-7EBF9A0D81B9%Eng1$Это очевидно%It\'s obvious%rus_eng%58E2324C-BECA-48B9-9705-80715A4571E6%Eng1$Зависит от тебя%Depends on you%rus_eng%59584C58-6CEA-433E-AAF0-0A8B4126607C%Eng1$Я удачливый?%Am i lucky?%rus_eng%59606D0A-0580-4A86-9665-3C963AB3A92D%Eng1$Тоже думает так же%Also think so%rus_eng%5A890459-8FEC-4DE2-A848-7520B5193C87%Eng1$Это мое Решение%It my Decision%rus_eng%5CE05A83-65E5-4D92-B842-2D6A615CA7A9%Eng1$День ветряный%The day is windy%rus_eng%613B69BA-6C89-430D-A89C-03512E92770E%Eng1$Слушать радио%Listen to the radio%rus_eng%6483D17D-3B4D-458C-8219-987505299518%Eng1$Он часто слышит это?%Does he often hear it?%rus_eng%681DDB9B-A30A-4F1C-9F1A-7C1D4EB4678B%Eng1$Какую музыку ты предпочитаешь?%What music do you prefer?%rus_eng%687C92A0-AC6A-467C-91AF-86722B049B5C%Eng1$Тепло%It\'s warm%rus_eng%69ED852C-2441-4CAD-A4CC-61DD2DA96B7D%Eng1$Отдыхать%Have a rest%rus_eng%6BCA26CB-0DE0-4E00-BF91-F227D4491E9B%Eng1$Знание сила%Knowledge is power%rus_eng%6C3BDC4A-F2C0-4111-9866-C2CA9A21AE9F%Eng1$реактивные привязки%Reactive Bindings%rus_eng%6C753EA9-5664-40CE-899A-D7F07F64ADF5%Eng1$Это естественно%It\'s natural%rus_eng%6E77F834-E32B-4F96-8921-987A836C35BD%Eng1$Статья на английском? (Так де значит артикль)%Is the article in English?%rus_eng%702C7C2F-8031-43EE-94F0-018559CE55F6%Eng1$Мы в парке%We\'re in the park%rus_eng%71F5054D-140E-4E02-B0F5-CD4F27B4CE58%Eng1$Обмен сообщениями в облаке%cloud messaging%rus_eng%748D6C0B-204B-41C1-97C8-EBA6B415DF35%Eng1$Улучшить%Improve%rus_eng%7572CB88-A690-4209-A527-9D4CE4BD82A9%Eng1$День ветряный%The day is windy%rus_eng%757AB1BA-677B-408F-8F84-235C268C20D4%Eng1$Добираться до туда/сюда/домой%Get there/her/home%rus_eng%75B90AF4-48B4-4069-9B31-B58E3C20D30C%Eng1$Они бедные%They\'re poor%rus_eng%7731AF93-E6C7-49B4-8440-75179ADEB7A1%Eng1$Это не так%It\'s not so%rus_eng%7A461AF8-6D17-45FD-9897-A25A57027B03%Eng1$Это комфортно для меня.%It\'s comfortable for me.%rus_eng%7F3EB4DC-90FD-49CD-912D-84740878FD41%Eng1$Блестящий результат%Brilliant result%rus_eng%7FBF222A-ACF1-497A-BA6F-22DFCC55F90E%Eng1$Какого рода книг ты читаешь?%What kind of books do you read?%rus_eng%85B50031-412D-4317-B624-2B2DF20DFAB5%Eng1$Это возможно/ не возможно%It\'s possible/impossible%rus_eng%85F01EE4-CEE2-43F0-BCBA-FD56BE99ABBA%Eng1$буфер обмена пустой%the clipboard  empty%rus_eng%86C09BA4-A031-4069-8BF7-70485134539F%Eng1$Не успешный(одно слово)%Unsuccessful%rus_eng%88585D8E-9BDF-4877-8600-675EEDA71819%Eng1$Как регулярно?%How regularly?%rus_eng%8A38173A-C258-401A-B540-66F8AD478A36%Eng1$Значек%Badge%rus_eng%8ACB414C-7B1C-4567-A446-48916A91F470%Eng1$привлекать%Attract%rus_eng%8BB741B5-8FE4-4973-BCD2-FFD6B7A152B0%Eng1$Они часто смеются над этим/ над ним%They often laugh at it/ at him%rus_eng%8EA43FD2-3052-45D8-8430-F27520D20AE5%Eng1$Сколько эти джинсы?%How much are these jeans?%rus_eng%91545B43-845C-4C51-B103-F38EA77D4E8C%Eng1$Почему твой друг хочет искать новую работу?%Why does your friend want to look for a new job?%rus_eng%919265D3-C27D-49DC-8523-72C5C58CA34B%Eng1$Темно%It\'s dark%rus_eng%91A7D12A-8B9C-415C-B0D2-DC06FE385D6F%Eng1$Это потеря времени / денег%It\'s a waste of time / money%rus_eng%91D6BFD4-FB27-4FAD-A44C-DD2D89D639C4%Eng1$Я холостой%I\'m single%rus_eng%92F2C8B3-4043-4FA1-BFB4-3BC61B25C612%Eng1$Они боятся этого?%Are they afraid of it?%rus_eng%94AEFA2F-E444-48BC-8DD5-42EBAA610A73%Eng1$получать%receive%rus_eng%99BD1605-2992-4193-8EC0-8529478DE499%Eng1$Сколько стоит эта пара брюк?%How much is this pair of trousers?%rus_eng%9DB30862-DEDE-4455-A74C-89824B3F8542%Eng1$Я не удовлетворен этим решение%I am not satisfied with this decision%rus_eng%A02143DA-B445-4F85-B1EB-1FF4F0CCA52B%Eng1$Критиковать%Criticize%rus_eng%A057FA21-63D1-4A58-A89E-CBE1E5C684A3%Eng1$Это ее мнение?%Is it her opinion?%rus_eng%A0AF6A7A-DA06-44F0-A19B-DDD5E495C4F2%Eng1$взаимодействовать с различными потоками%interact with various streams%rus_eng%A1847E38-E83E-4A89-8336-BBAD881706E6%Eng1$Это его собственная квартира?%Is it his own flat?%rus_eng%A1EA5A76-9C31-4479-A985-9140F3CD600E%Eng1$явный эпл айди%explicit app id%rus_eng%A264BBD0-338A-4E1A-B86B-076CC9F84FFF%Eng1$Что в твоем кармане?%What\'s in your pocket?%rus_eng%A27EF155-DD99-4D62-97AF-2CE532D89A14%Eng1$Специальное предложение%Special offer%rus_eng%A2A04385-1D84-46D5-B6F7-F8CDAEA9BD49%Eng1$Это кажется скучным?%Does it seem boring?%rus_eng%A2AB6EC3-3654-427F-BC20-83E7921156A4%Eng1$потомок%Descendant%rus_eng%A34FC96C-FA82-41DA-AB1B-103591D54E8C%Eng1$Те уроки не эффективные%Those lessons are ineffective%rus_eng%A44396AE-69BA-474C-9974-2ECD29F98DD8%Eng1$рукопожатие%handshake%rus_eng%A44A1D92-5225-4CED-978A-22013B68670A%Eng1$Он в здании?%Is he in the building?%rus_eng%A45A819D-5EF3-420B-AF6D-64F9F77C148B%Eng1$Во сколько ты ложишься спать?%What time do you go to bed?%rus_eng%A4B4556C-E1F7-4C80-B8F0-D8DFBB5718D5%Eng1$Я не женат%I\'m not married%rus_eng%A74C25FA-00AC-4F13-9098-64513FCCBCB4%Eng1$Как часто ты занимаешься англ?%How often do you learn english?%rus_eng%A7D60F74-9BEA-4FC7-ADF1-EA46D17EFC97%Eng1$Откладывать%Defer%rus_eng%AB141804-45D4-4A6D-B434-DCF6E8B983C1%Eng1$Это хорошая манера%It\'s a good manner%rus_eng%AD1E5366-6E8C-41AD-82DC-B03738CA1260%Eng1$Любовь прекрасное чувство%Love is a wonderful feeling%rus_eng%AF86A536-52B9-46DE-B6DE-76BBB8FB38F2%Eng1$Это мое окончательное решение.%It\'s my final decision.%rus_eng%B0932F9D-C667-4F99-AE9C-73AF2B9BE4EE%Eng1$Солнечно%It\'s sunny%rus_eng%B0976867-4FE8-4F21-A9F1-D2A9359A5FF2%Eng1$Я обожаю иностранные языки.%I enjoy foreign languages.%rus_eng%B2A35311-E549-4D4C-8052-3B8C83CBB209%Eng1$Решать%Solve.%rus_eng%B58DED38-C5F2-470B-81C9-DCF98523841E%Eng1$Почему он жалуется так часто?%Why does he complain so often?%rus_eng%B99E15BF-060C-4708-9435-EDD072138EEA%Eng1$Неудобный.%Inconvenient.%rus_eng%BAAB31C9-5B61-4DBD-A6F7-BC048ADD9F9A%Eng1$Этот экзамен кажется очень сложным?%Does this exam seem very difficult?%rus_eng%BACA85F7-5ABB-478C-A17B-2F36E360B939%Eng1$Держите ваш доступ до конца вашего текущего членства%Keep your access until the end of your current membership%rus_eng%BD68526B-282D-4BD8-AE95-5E8D80E301E6%Eng1$Они ленивые%They\'re lazy%rus_eng%BFA1716D-10DA-4BC6-9C81-CBFC69970453%Eng1$Обещать%Promise%rus_eng%BFB41E3C-0C74-4B91-9F5D-3E4377D6E680%Eng1$Он в командировке%He\'s on a business trip%rus_eng%C656B423-2392-4ECD-9421-4E6808F7CBC9%Eng1$Это не вдохновляет меня%It doesn\'t inspire me%rus_eng%C6B32BC9-D630-4D47-BCAA-238727F2707A%Eng1$Я конечно%I  certainly%rus_eng%C89EFA42-BC90-4963-AA2D-D6AACEE7364B%Eng1$Вовсе%At all.%rus_eng%C9B53D0E-D405-4FC0-B039-8FCBA35367F9%Eng1$Ты не прав//%You aren\'t right/ you are wrong%rus_eng%CAFD30DC-3388-4273-855C-9021CD973C79%Eng1$Это большой успех%It\'s a big success%rus_eng%CDEFBD05-9AD2-4F22-8511-375CB487A282%Eng1$Это очень высокий/низкий уровень%It\'s a very high/low level%rus_eng%CEA5E63C-4166-4DBF-9472-8BBD13C16F9F%Eng1$привязки модуля представления%bind view model%rus_eng%CFC1FE21-4942-493E-A3C9-F878CC51CE16%Eng1$Я получаю удвольствие от анг / спорта%I enjoy english / sport%rus_eng%D259F99C-3AD7-49C5-B831-1A4A163C64EC%Eng1$как можно скорее%As soon as possible -%rus_eng%D89DB3C7-D77C-42A9-9984-8437605ADDE3%Eng1$Мы не в правильном месте?%Are we in the wrong place?%rus_eng%DF6C331B-648C-4065-A98A-84793B85DE87%Eng1$Требования метода.%Method requirements.%rus_eng%DF9D826A-E0C0-404E-AC8F-CC3A89869B3C%Eng1$Сколько стоят эти брюки?%How much are these trousers?%rus_eng%E09ACF22-93B1-465F-B4B8-02EE19D53B07%Eng1$Обьяснять%Explain%rus_eng%E1FCA315-B43D-43EB-84EB-9DBB3A854F2C%Eng1$макет%mock%rus_eng%E21FA769-B971-4475-8DED-364467107E8E%Eng1$Заранее спасибо%Thanks in advance%rus_eng%E336F615-D23D-4112-A2DA-85B74FF80E5B%Eng1$Способность%Ability%rus_eng%E3D69A14-65A1-4306-A957-E8D6448CEC2A%Eng1$Я на работе%I\'m at work%rus_eng%E41B0DCE-1C12-4926-ADBB-BC7C5CB8228C%Eng1$исправить эти ошибки%To correct these mistakes%rus_eng%E671F7FE-A0D4-4486-A75D-3C85143312CF%Eng1$Она такая мудрая женщина%She\'s such a wise woman%rus_eng%E684BF04-7BDD-4645-87B7-FD8718A07C06%Eng1$Мы не злые%We aren\'t angry%rus_eng%E7DA0F5C-7F81-4578-8AAF-2D6EC9A43A2E%Eng1$Я дома%I\'m at home%rus_eng%EA9228B9-24A6-4304-966D-1AEE739F0451%Eng1$Правило%Rule%rus_eng%EE4D700E-DC68-40F2-A2D8-4E40762EC2B8%Eng1$Это лучше/хуже%It\'s better/worse%rus_eng%F0D58EA0-4E89-4D0F-B7D4-485ADF95202A%Eng1$это может быть проблемой?%could that be the issue?%rus_eng%F3BF0CE5-E84B-4B47-A2EC-4B83A3EE333D%Eng1$согласен%Agree.%rus_eng%F673E116-26A2-4C8A-8735-8CBB6D2A5458%Eng1$Ты прав%You\'re rigth%rus_eng%F6F03618-C883-4DDF-8216-818A3FFCFE8E%Eng1$Я уверен (2 варианта)%I am sure/ I am certain%rus_eng%F7545ECC-3F09-4356-9B4E-AF4B1AF292EA%Eng1$Не соглашаться с тобой%Disagree with you%rus_eng%FCD7773F-B1FC-4F60-812A-1CE92B1D5139%Eng1$Они не смогут разрешить этот конфликт.%They won\'t be able to resolve this conflict.%rus_eng%05158D66-3815-4651-9EE6-7C9EB48F0EE5%Будущее время$Я буду гордится вашими результатами.%I will be proud of your results.%rus_eng%05D1198B-2FD2-4C61-94E7-5EB1E3715DB7%Будущее время$Он скоро женится.%He will get married soon.%rus_eng%0A463A9E-8443-479E-B3D1-E24DBFA417EA%Будущее время$Это будет потенциальная угроза?%Will it be a potential threat?%rus_eng%0CA1CDF6-FA14-450F-85A3-09D6D4378ECE%Будущее время$Тебе повезет.%You\'ll be lucky.%rus_eng%0E2C3A3E-CDA5-4D1C-A722-191A51E10580%Будущее время$Это будет длиться вечно?%Will it last forever?%rus_eng%1024B154-9592-4349-B89D-FB29B00DFB5E%Будущее время$Мы не будем конкурировать с этой компанией.%We won\'t compete with this company.%rus_eng%114292B8-6EE1-4CB1-B233-12F8E46E5638%Будущее время$Это произойдет рано или поздно.%It\'ll happen sooner or later.%rus_eng%1173B230-EED2-4C46-9C98-C61FC1FD6596%Будущее время$Власти будут регулировать это как то.%The authorities will regulate it somehow.%rus_eng%12C22B40-2ADA-4EA3-A8F0-924DF197CB71%Будущее время$Это будет не законно.%It won’t be legal. (It’ll be illegal)%rus_eng%1374181E-6452-4A44-BAF2-43D915836824%Будущее время$Они скоро разведутся?%Will they get divorced soon?%rus_eng%139A788A-BFE4-406A-A114-37C1CA2EEE93%Будущее время$Мы минимизируем издержки.%We will minimize the costs.%rus_eng%139EC145-FE0F-4F65-9FFB-3A19C2602112%Будущее время$Этот результат впечатлит их?%Will this result impress them?%rus_eng%148DDAEA-7AD7-4A59-AABA-DDE2C0A73DBD%Будущее время$Мы с моим другом будем уделять английскому/здоровью больше свободного времени.%My friend and i will devote more free time to English/ health.%rus_eng%152189C0-C5A9-45CD-A7A0-279D58D95931%Будущее время$Я заработаю 500 долларов.%I\'ll earn 500 dollars.%rus_eng%1B104815-B7CC-4A9C-B882-86DBFFC417ED%Будущее время$Мы с другом поторопимся.%My friend and i will hurry up.%rus_eng%1DB63042-2284-4427-BF8B-A51D6AF7B654%Будущее время$Как ты сумеешь решить эту проблему?%How will you manage to solve this problem?%rus_eng%1E7B4D80-43B6-4D2C-AF2E-91C363970A33%Будущее время$Этих знаний будет больше чем достаточно.%This knowledge will be more than enough.%rus_eng%1EA0DDA2-8031-4F3A-B69D-F5D807BBEDA2%Будущее время$Сколько денег ты потратишь на это?%How much money you will spend on it?%rus_eng%1EC30377-D8DD-44E5-B571-CE2BB4478810%Будущее время$Я постараюсь не делать это.%I\'ll try not to do it.%rus_eng%2178813A-A732-4373-B912-E26395C7212F%Будущее время$Послезавтра%The day after tomorrow%rus_eng%217D896D-9573-4766-A06A-B684A50E5B22%Будущее время$Я думаю он будет обожать спорт, но это не обязательно означает, что он станет профессиональным спортсменом.%I think he\'ll fond of sport but it doesn\'t necessarily mean that he\'ll became a professional sportsman.%rus_eng%2322A631-B555-4715-8B19-46FA4419CF04%Будущее время$Что будет принадлежать ему?%What will belong to him.%rus_eng%2323406E-C3A0-439E-B5F7-65F15B93AB39%Будущее время$Когда она присоединится к нам?%When will she join us.%rus_eng%25DF48C9-66BE-4C1E-A5B2-76CEEE8CBF44%Будущее время$Ты будешь скучать по ней?%Will you miss her?%rus_eng%2760D6B2-0BEF-483D-98F8-1D1F65DC9BEC%Будущее время$Жизнь накажет его.%Life will punish him.%rus_eng%27BD8A41-4761-4022-8C46-205907C4462B%Будущее время$Он отправит ему такое важное письмо.%He\'ll send him such an important letter.%rus_eng%27CD3116-CF8E-4B89-85D5-2F08CB8B45D8%Будущее время$Этот канал поможет вам выучить английский бесплатно.%This channel will help you learn English for free.%rus_eng%296FB87F-DDD9-45DC-9DE7-E815A8D7DC11%Будущее время$Мои коллеги не поддержат эту инициативу.%My colleges won\'t support this initiative.%rus_eng%2EECACD9-6CF1-40C4-B7C6-B0304E20212D%Будущее время$Ты не сдашь этот экзамен без подготовки.%You won\'t pass the exam without preparation.%rus_eng%32D6345E-0E71-421D-9E8C-941C4A93B878%Будущее время$Мальчик не выучит это за один день.%The boy won\'t learn it in one day.%rus_eng%3300B39E-4304-4716-ADE2-089B417FA316%Будущее время$Ты пропустишь этот автобус?%Will you miss this bus?%rus_eng%3317EC8C-12FD-4575-B99E-2E43B1A833C8%Будущее время$Сколько времени ты потратишь на это?%How much time will you spend on it?%rus_eng%36C5E4A4-D08E-46EC-88CF-6EB345FFCCA0%Будущее время$Они будут есть свежие овощи и фрукты.%They will eat fresh fruit and vegetables.%rus_eng%3F32EC10-DD74-4C43-A738-2CACCCF4FD6E%Будущее время$Они будут вести себя более осторожнее.%They\'ll behave more carefully.%rus_eng%46CA4205-369E-41CE-A1BF-95F5EBB7FBA4%Будущее время$Она последует твоему совету.%She\'ll follow your advice.%rus_eng%48AD580C-7D78-4953-958C-8563B43D7ACD%Будущее время$Принимать серьезные меры.%Take serious measures.%rus_eng%49694A14-93FC-4BAF-820A-CD1C5C792925%Будущее время$Необходимо будет подписать отчет?%Will it be necessary to sign the report?%rus_eng%4AE6D3B1-4271-43FE-A810-9DDB7DC8790A%Будущее время$Мой босс не будет настраиваться на это.%My boss won\'t insist on it.%rus_eng%4B2E2841-6029-4FA4-9F4C-E5534B378D2E%Будущее время$Привести к успеху.%Lead to success.%rus_eng%4B8BD67B-14F9-4051-8108-B8D9C34728B6%Будущее время$Как они смогут решить проблему?%How will they be able to solve this problem?%rus_eng%4E6D5276-97A6-4B3C-A1B1-55E1496E03C9%Будущее время$Я не буду перебивать его.%I won\'t interrupt him.%rus_eng%50223862-0872-4CC7-A946-E43B3C91CE51%Будущее время$Она сохранит этот секрет.%She will keep this secret.%rus_eng%50EA469E-0B83-4FAF-AFF4-039224BC2604%Будущее время$Я смогу улучшить свой английский очень сильно(значительно).%I will be able to improve my english greatly(significantly, considerably)%rus_eng%5173DDAF-FE3D-4DE4-B372-DEDB7ECD2EE0%Будущее время$Жизнь преподаст ему рок.%Life will teach him a lesson.%rus_eng%53142401-02F9-43D5-8E68-D8D773812559%Будущее время$Наш менеджер по продажам посчитает это.%Our sale manager will calculate it.%rus_eng%5537B0DA-7259-43D9-9944-2960D2BF8A81%Будущее время$Все выразят неудовлетворенность текущей ситуацией?%Will everyone express their dissatisfaction of the current situation?%rus_eng%55AA4724-0D20-4A2B-A230-0768FC1F9420%Будущее время$Это не приведет к успеху.%It won\'t lead to success.%rus_eng%564B2FB6-F34F-4BB0-A59D-CBF93B9FEBDA%Будущее время$Я сумею удвоить наши продажи, не смотря на кризис.%I\'ll manage to double our sales, despite (in spite of) the crisis.%rus_eng%5BAFDBDA-2631-48D9-AF74-90B2C90EFBCA%Будущее время$Он не будет курить больше.(дольше)%He won’t smoke anymore.(any longer)%rus_eng%5BC55212-5901-481C-846A-B75F01E8F18A%Будущее время$Эти условия подойдут нам.%This conditions will suit us.%rus_eng%5DD60F7B-F4D2-4168-B9C6-480861A9C8B3%Будущее время$Этот подход не будет достаточно инновационным.%This approach won\'t be innovative enough.%rus_eng%5FE5C8CA-EBB4-4A70-906C-2055822B6C5C%Будущее время$Мы сэкономим деньги.%We\'ll save money.%rus_eng%673C8044-6FFC-4785-A719-F7EF930E51EA%Будущее время$Его нет дома.%He is out.%rus_eng%6A68EB26-00A7-4056-B8B7-D195704ED729%Будущее время$Настаивать на этом.%Insist on it.%rus_eng%6A938E43-F71E-47E8-AF37-3C010D8B75D7%Будущее время$Это не принесет тебе больше денег.%It won\'t bring you more money.%rus_eng%6CACB604-4F41-4A12-9EE7-3E435129EF6D%Будущее время$У них будет выбор.%They will have a choice.%rus_eng%701B2E5F-67EE-4DD3-A4AF-1148D30E1C25%Будущее время$Мы будем благодарны тебе за это.%We\'ll be grateful to you for it.%rus_eng%71226506-36F1-4E37-806D-CDA02DE390B4%Будущее время$Мог - сможешь - смогу в будущ.%Could - can - will be able.%rus_eng%73740CAC-4D61-46D1-8422-7C1795A44E2D%Будущее время$Мы не будем жаловаться об этом.%We won\'t complain about it.%rus_eng%7E5BE521-99BF-4C22-97F1-E3C883DD2EFE%Будущее время$Стемнеет скоро?%Will it get dark soon?%rus_eng%7EB942B3-597E-4FB5-B54F-9ADFB32E7FDC%Будущее время$Я достигну этой цели.%I\'ll achieve this aim.%rus_eng%847C2662-EE4C-4D77-9E1E-CF09E9CF25D2%Будущее время$Как долго твои родители будут отсутствовать?%How long will your parents be away?%rus_eng%85D33245-19DE-4421-8216-984EE387C02C%Будущее время$Все будут расстроенные.%Everyone will be disappointed%rus_eng%875DE131-A3EE-4A12-97DF-67B2741FF9A6%Будущее время$Он отсутствует.%He is away.%rus_eng%8A0ABEC9-FF00-4CDE-95CF-69A6ADB37C82%Будущее время$Мое произношение будет намного лучше?%Will my pronunciation be much better?%rus_eng%8B219539-9132-4734-B2EA-9D24CF378C19%Будущее время$Девочка завалит этот экзамен?%Will the girl fail this exam?%rus_eng%8FE98784-5AE4-4281-B7BC-1C0B2BF38549%Будущее время$Его бизнес партнер пожалеет об этом.%His business partner will regret it.%rus_eng%9009C8DE-4A56-432C-B2C3-1CCB0502685E%Будущее время$Люди часто путают эти слова.%People often confuse/(mix up) these words.%rus_eng%90F6FF3E-DB5A-4142-A10A-EEFF215D99E0%Будущее время$Учитель простит им.%The teacher will forgive him.%rus_eng%91660C05-207F-4338-86B5-940FB31B79A5%Будущее время$Ты укажешь на мои ошибки?%Will you point at my mistakes?%rus_eng%92DE7C22-0501-4B1C-B283-90CF874CDBCD%Будущее время$Большой / огромный успех.%Big /(huge, tremendous) success.%rus_eng%96A1C59F-BBB1-4E6E-BDC0-5AF16393C118%Будущее время$Мы обдумаем это.%We\'ll think it over.%rus_eng%9B456900-A0B1-4268-8935-7918B1F4FF01%Будущее время$В чем причина этого?%What is the reason for it?%rus_eng%A14C3EAA-0564-415D-AE21-8FBF09FA5CE2%Будущее время$Какие каналы твои друзья будут смотреть на регулярной основе?%Which channels will your friends watch on a regular basis?%rus_eng%A3DD23AD-2C5B-4D8B-BB6B-309FB16D5C9F%Будущее время$Все выразят свою точку зрения?%Will everyone express their point of view?%rus_eng%A5623B1C-5DD8-4503-AE49-E4614DC62E4C%Будущее время$Ты не повлияешь на него.%You won\'t influence him.%rus_eng%AB825002-9D79-4186-BCBC-7AFE476D9011%Будущее время$Директор упомянет это позже?%Will the director mention it later.%rus_eng%B109397C-091A-406A-909B-7A150719E07B%Будущее время$Дешево%Cheaply%rus_eng%B46248F1-8AF1-4CC5-B1E6-517D611EE331%Будущее время$Это будет стандартная процедура?%Will it be a standard procedure?(просиджи)%rus_eng%B4BA3DFD-A372-47D9-8CF7-FB0DDE60F3CA%Будущее время$Он починит это.%He\'ll repair it.%rus_eng%B5C29099-F6C8-4488-BF59-8657BC0AD951%Будущее время$Этот мальчик сдаст наконец экзамен?%Will this boy pass the exam at last?%rus_eng%B6DECDA5-8B16-442C-8272-F4242ACAD2DB%Будущее время$Она не будет отрицать этот факт.%She won’t deny this fact.%rus_eng%BD4D5DD4-BA48-464F-994F-08EC5CDD5BC0%Будущее время$Это будет нашим достижением.%It\'ll be our achievement.%rus_eng%BD632D82-4D56-4107-89F7-692B09E2363B%Будущее время$Они не найдут решение этой проблеме.%They won\'t find a solution to this problem.%rus_eng%C09D8CAD-EBA0-4489-B1B6-F8AF09A0A898%Будущее время$Мне кажется день не будет дождливым.%It seems to me the day won\'t be rainy.%rus_eng%C7BD8957-11AD-494E-A55B-14F812FEDA7E%Будущее время$Необходимо будет проверить это более тщательно.%It\'ll be necessary to check it more thoroughly.%rus_eng%C800E327-894B-402C-8E95-988BC0378924%Будущее время$Это поменяет мое отношение к этой проблеме?%Will it change my attitude to/towards this problem?%rus_eng%CBFE0340-5853-48B8-B3C6-A6B57C966EB0%Будущее время$Где будет проходить конференция?%Where will the conference take place?%rus_eng%CC54D97F-AF12-41A4-9235-B38C14C7B7FE%Будущее время$Неудобный.%Inconvenient.%rus_eng%CD5E4EC3-5C83-4345-9687-C7F3F32D5FDB%Будущее время$Это будет длиться около двух часов?%Will it last for about two hours?%rus_eng%CD877BAB-1240-481D-9C5D-14EE6C1C757E%Будущее время$Я сумею сделать что то. Я сумею сделать это.%I\'ll manage to do something. I\'ll manage to do it.%rus_eng%CF9F4F52-C3C1-424B-BFF7-C915F6C2D73B%Будущее время$Студенты посмотрят это в словаре?%Will the students look it up in a dictionary?%rus_eng%D14D838A-E54B-40B9-B386-C24F7159E659%Будущее время$Эти меры будут стимулировать наши продажи.%These measures will stimulate our sales.%rus_eng%D490FBC0-AF1F-4E64-B42A-B769F7721CE2%Будущее время$Я постараюсь не упоминать это.%I\'ll try not to mention it.%rus_eng%DB905370-EE20-448B-B0A6-7C913C26FC6A%Будущее время$Мой бизнес партнер отдолжит ему эту сумму денег.%My business partner will lend him this sum of money.%rus_eng%DD267F78-842B-4DFE-92AF-C48C694AD543%Будущее время$Это будет длиться больше двух часов?%Will it last for more than two hours?%rus_eng%DE4AC336-2988-4380-9105-5D4141B37B0D%Будущее время$Сколько денег ее муж будет должен им?%How much money will her husband owe them?%rus_eng%DEB89C83-1A6E-4243-855F-35C7E82567C9%Будущее время$Он жениться на ней.%He will marry her.%rus_eng%E04A6579-D649-480F-9E94-11E66C041516%Будущее время$Я думаю нам не нужно изобретать заново колесо.%I think we don\'t need to reinvent the wheel.%rus_eng%E09677D2-2B07-4073-A4D6-592C70F1B4A5%Будущее время$И так далее.%And so on. (etc. - et cetera)%rus_eng%E548C85E-A854-4A27-8DE4-3050CFDC0007%Будущее время$Ты будешь доступен завтрашним утром?%Will you be available tomorrow morning?%rus_eng%E611897A-078D-44AA-BED4-AD0B7DD69BCB%Будущее время$Студент отгадает правильный ответ?%Will the student guess the correct answer?%rus_eng%E825EE60-B419-4D6A-9061-5AC135716DEA%Будущее время$Я не буду принимать участия в этом соревновании.%I won\'t take part in this competition. (participate)%rus_eng%E855D204-EA23-4F76-B859-7150A183DE93%Будущее время$Гости не заметят наше отсутствие.%The guests won\'t notice our absence.%rus_eng%E8674191-EFDD-45D7-9F0F-5B7B4A31116F%Будущее время$Она не будет реагировать на это.%She won’t react to it.%rus_eng%EC360408-EA0B-4D31-9011-2E4562310B37%Будущее время$Ты будешь интересоваться этим?%Will you be interested in it?%rus_eng%EFBD1D0D-B82B-449D-8CDB-AFDB188784A9%Будущее время$Они смогут найти это везде.%They\'ll be able to find it everywhere.%rus_eng%F4E0A094-F53B-4678-93DB-3E7E88D2EAD8%Будущее время$Это удивит тебя очень сильно.%It\'ll surprise you greatly.%rus_eng%F520F7BC-9DB3-461C-A537-7AFFEA055226%Будущее время$Его друг займет эти деньги.%His friend will borrow this money.%rus_eng%FC5FFF35-A1A2-458B-9C8B-A1AE7F6E346A%Будущее время$Ты устанешь. (Ты станешь уставшим)%You will get tired.%rus_eng%FF5AA295-97ED-4A5B-813F-0D6985DC5A53%Будущее время$Кататься%Ride rode ridden%rus_eng%05045C90-11BE-4E26-A660-7A05A1AFD70B%Не правильное прошлое$Он украл ювелир украш.%He stole jewelry.%rus_eng%0613F420-44BE-43F0-8ACE-3058B80A7E8F%Не правильное прошлое$Он поставил стакан воды на стол.%He set a glass of water on the table.%rus_eng%061D890C-412A-4E9C-95EE-670DD9159673%Не правильное прошлое$Он сделал мне одолжение.%He did me a favor.%rus_eng%0931E1A6-52CC-4F08-B976-25828846E0A1%Не правильное прошлое$Мы выиграли в том соревновании.%We won in that competition.%rus_eng%098DE162-EBD9-483C-8335-4EBAB48D8FB5%Не правильное прошлое$Я услышал это в новостях.%I heard it in the news.%rus_eng%09E001EF-13F2-4D9D-949D-A5AF4022BEB9%Не правильное прошлое$Он написал такую интересную книгу.%He wrote such an interesting book.%rus_eng%0E297A34-50A3-479B-95F1-EBF01ADE070D%Не правильное прошлое$Я сел на стул.%I sat on a chair.%rus_eng%0EB4DC21-FEAC-4720-96E4-7AD79C552122%Не правильное прошлое$Я присел.%I sat down.%rus_eng%0F5418DB-5D78-400B-AA10-12DC74B01D81%Не правильное прошлое$Я поспал 10 часов.%I slept for 10 hours.%rus_eng%0FF444DF-591D-4E24-8A0C-302F652F4F7C%Не правильное прошлое$Летать%Fly flew flown%rus_eng%11B149B6-500A-44A4-B975-3532D913D64E%Не правильное прошлое$Этот солдат сражался очень отважно.%This solder fought  very courageous.%rus_eng%12EAA305-BA09-4F56-84E2-AD46D481972D%Не правильное прошлое$Понимать%understand - understood - understood%rus_eng%14B1E369-5189-4151-BFF7-B6F231AAEB3B%Не правильное прошлое$Он бросил курить.%He gave up smoking.%rus_eng%150B185F-2408-4C2A-8D8D-69786C1A0117%Не правильное прошлое$Чувствовать%Feel - felt - felt%rus_eng%1615112B-3113-47D9-8A0F-E5F1938A6CFA%Не правильное прошлое$Я поставил это на стол%I laid it on the table.%rus_eng%169ACE76-F2CE-413B-BADA-EEE2C08804D7%Не правильное прошлое$Я носил ремень%I wore a belt%rus_eng%17028C5D-6CB1-4E8F-BCAE-2456A253ADC3%Не правильное прошлое$Бежать.%Run - ran - run.%rus_eng%17469860-FFE8-4D4C-A2C3-52872E6D9021%Не правильное прошлое$Резать%Cut - cut - cut%rus_eng%18128E8B-6EA9-44F3-AC51-F075C721FD68%Не правильное прошлое$Продовать%Sell sold sold%rus_eng%18516A92-D54A-404B-AAB9-9EC38A0C58D3%Не правильное прошлое$Он выпил стакан вина.%He drank a glass of wine.%rus_eng%1DAECF39-F328-47E6-9230-B4EFD9AB94DF%Не правильное прошлое$Ловить%Catch - caught caught%rus_eng%1DB0DE9B-8DEF-473C-B588-AE6A165AD08A%Не правильное прошлое$Он пошел на работу.%He went to work.%rus_eng%1E245997-7CB0-4171-8590-1D64B81138F8%Не правильное прошлое$Быть%Be, was - he, she, it, were%rus_eng%1F21F156-CBA7-45A8-84FC-D36DB7502468%Не правильное прошлое$Сказать кому то%Tell - told - told%rus_eng%1F31D0C4-5C98-42B3-81F5-B74AB65081F8%Не правильное прошлое$Позволять.%Let - let - let.%rus_eng%1FD5D684-5DBC-4410-80CD-D3535B773456%Не правильное прошлое$Ставить%Put - put - put%rus_eng%23F5AC62-AF3D-48A2-8AFE-016A8DD90AD3%Не правильное прошлое$Он намеревался помочь мне.%He meant to help me.%rus_eng%2557F2F7-5D95-4B2F-98C4-DC6E37C74105%Не правильное прошлое$Писать.%Write - wrote - written.%rus_eng%2892E3C2-C885-4FAE-8EBA-27D73D7E69E4%Не правильное прошлое$Ушибить(ушибся)%Hurt hurt hurt%rus_eng%2A1A8FC4-B667-4808-9F28-D3105E0DF007%Не правильное прошлое$Я записал это слово.%I wrote this word down. I wrote down this word.%rus_eng%2AD88954-B693-4BA9-B770-C8DAA3ED053E%Не правильное прошлое$Рисовать%Draw drew drawn%rus_eng%2C89AF40-9A89-4C7A-87AF-60D54FEA347F%Не правильное прошлое$Поставил, установил%Set set set%rus_eng%2CC652F4-BA28-48A9-9010-82E88896F838%Не правильное прошлое$Платить%Pay paid paid%rus_eng%2EF09163-83C5-41F0-8881-047EF5AA42D7%Не правильное прошлое$Я вырос в маленьком городке.%I grew up in a small town.%rus_eng%2F09979B-105F-402F-AADC-2DA8589CE98B%Не правильное прошлое$Он вырыл яму%He dug a hole%rus_eng%309C4192-2F2E-46AA-8CD5-E721976B914C%Не правильное прошлое$Он побежала очень быстро.%She ran very fast.%rus_eng%325A5554-0CE9-438F-939D-BCCBB4BDB9C4%Не правильное прошлое$Я плавал в озере.%I swam in the lake.%rus_eng%3263D016-C833-4163-AEF4-99D258B8636E%Не правильное прошлое$Ушибить, задеть%Hurt hurt hurt (injured правильная форма)%rus_eng%3435BE74-CCB5-44D6-98E6-00DA38B12514%Не правильное прошлое$Он убежал.%He ran away.%rus_eng%3456C5B6-3E6B-4C71-8555-958CC32C7BE7%Не правильное прошлое$Думать%Think - though- though%rus_eng%360E857C-A244-4159-9A13-DFE5DDBC2508%Не правильное прошлое$Мы ловили рыбу%We caught  fish%rus_eng%37DCD079-950A-4B7D-BF9E-59EC55CBCA80%Не правильное прошлое$Держать(руками например)%Hold held held%rus_eng%39918636-70F8-4FA6-A930-1FD55A08F610%Не правильное прошлое$Я услышал это по радио.%I heard it on the radio.%rus_eng%39D214E9-35D1-48BA-84FD-E01311A15810%Не правильное прошлое$Он сказал мне все.%He told me everything.%rus_eng%39D65AA6-31E3-4C3D-BC62-0BD287D18748%Не правильное прошлое$Значит.%Mean - meant - meant.%rus_eng%3B7078E2-574C-4301-B267-AD201AD8E5B9%Не правильное прошлое$Встречать%Meet - met - met%rus_eng%40314E5A-14C1-47B1-B50A-9830D90368F8%Не правильное прошлое$Его машина сломалась.%His car broke down.%rus_eng%428BC027-E5D3-4E31-8D07-071325E45346%Не правильное прошлое$Идти%Go - went - gone%rus_eng%4386F8CB-5FAC-41A4-BA4D-3C1436FFF470%Не правильное прошлое$Он показал блестящие результаты.%He showed brilliant results.%rus_eng%452226BE-4DF8-49C1-B542-04F08EBB8FBB%Не правильное прошлое$Я потратил 700 дол на это.%I spent 700 dol on it.%rus_eng%48BB3EE9-F921-42E9-8736-BFAA539F40EA%Не правильное прошлое$Хранить%Keep kept kept%rus_eng%48D8FCE3-7EBA-40F4-A831-571B251518EA%Не правильное прошлое$Он порезал мясо на 4 части(кусочка)%He cut the meat into for parts. (pieces)%rus_eng%491EA9DE-765C-4939-B035-68042FD1E467%Не правильное прошлое$Он спрятался за тем зданием.%He hid behind that building.%rus_eng%4C09C361-03A7-47A5-94B6-F232F44593E1%Не правильное прошлое$Лгать%Lie lied lied%rus_eng%4CDA6A1B-0267-40C1-932F-71C290076DFD%Не правильное прошлое$Покидать.%Leave - left - left.%rus_eng%4D17A8B8-7606-4352-8B19-6E6BFE90C0F6%Не правильное прошлое$Это значило следущее.%It meant the following.%rus_eng%4D5DAD50-9F2C-4D61-932A-1A65E7CDD79D%Не правильное прошлое$Она покормила своего малыша.%She fed her baby.%rus_eng%4F8F58FD-5EC6-4F73-9740-739C75485435%Не правильное прошлое$Он нарисовал шедевр%He drew a masterpiece%rus_eng%50FCC1E6-B4C8-40C6-99A8-E502BCF8DC91%Не правильное прошлое$Я одолжил ему эту сумму дененг.%I lent him this sum of many.%rus_eng%5197152E-5FFF-4C3B-9F15-5EC7EB3382B0%Не правильное прошлое$Я встал.%I stood up.%rus_eng%52403871-B6D2-4D27-A85C-E5720D2986EE%Не правильное прошлое$Намереваться что то делать.%Mean to do something.%rus_eng%52BE19CF-5EDD-4091-BF65-1FFDAC5A77A5%Не правильное прошлое$Я обычно спал около 8 часов.%I usually slept for about 8 hours.%rus_eng%554196AC-ADA3-486C-B986-2BBC2B0DE653%Не правильное прошлое$Я ел это на завтрак.%I ate it for breakfast.%rus_eng%575FBD0C-6D33-4852-9737-31188C046EB5%Не правильное прошлое$Они ударили его очень сильно.%They hit him very hard / badly.%rus_eng%5951E42E-874F-4237-B321-1116791A05FE%Не правильное прошлое$Ветер вдруг подул.%The wind blew suddenly.%rus_eng%59B322ED-573E-41EB-B07A-637449A1E1C5%Не правильное прошлое$Купить%Buy bought bought%rus_eng%5A4F5F35-2911-4CF6-B50C-541EF045224E%Не правильное прошлое$Я заплатил за эту услугу%I paid for this service%rus_eng%5E4A3448-C7FD-4F8D-A961-6453170119EC%Не правильное прошлое$Она мечтала о карьере в музыке.%She dreamt about a career in music.%rus_eng%5F1D14F0-DD5E-4015-ACB0-E5874A98DA0A%Не правильное прошлое$Я понял тебя сразу.%I understood you immediately / at once.%rus_eng%615325E1-2E22-485C-944C-991FEE338E5B%Не правильное прошлое$Я прилег%I lay down%rus_eng%62CBD43C-466F-4EF9-9308-222E6D8D692C%Не правильное прошлое$Отправлять%Send sent sent%rus_eng%6443F9D3-932A-4607-A5F3-DA37BECD0472%Не правильное прошлое$Я полетел в америку%I flew to america%rus_eng%669FA18B-F189-4CB3-9BA5-7542C5548C07%Не правильное прошлое$Сказать -%Say - said - said%rus_eng%6A4A7B08-FC95-4EE2-87C5-9E6DB9E835EB%Не правильное прошлое$Услышать.%Hear - heard - heard.%rus_eng%6ACF7D80-F7D0-437A-993D-73F00A6A12E1%Не правильное прошлое$Они сражались очень смело%They fought very bravely%rus_eng%6EA9CD8F-AB56-4635-8E46-27B8930C95CD%Не правильное прошлое$Учить%Learn learnt learnt Learned learned%rus_eng%6FEBF184-D600-4D7A-A5FD-FFDCF352AF48%Не правильное прошлое$Они разбили окно.%They broke the window.%rus_eng%716230C3-6203-45B0-B1A6-97535C5EF437%Не правильное прошлое$Мы знали это в начале.%We knew it in the beginning.%rus_eng%77CD9356-6571-49BB-874F-7559520B67BC%Не правильное прошлое$Ударить%Hit hit hit%rus_eng%79EC3BC5-26C3-49F9-99B8-1A2D75F1B2EA%Не правильное прошлое$Могу%Can - could%rus_eng%7AF5AEEA-5EC5-401A-8C6B-9795689450BB%Не правильное прошлое$Поставить%Lay laid laid(set, put)%rus_eng%7B0D8F49-8031-4679-AB99-E276CEF67B80%Не правильное прошлое$Я записал это.%I wrote it down.%rus_eng%7BD9E6B7-65C3-4603-B35D-C9A2B89A7F7E%Не правильное прошлое$Прятаться%Hide hid hidden%rus_eng%7C643112-566E-4C9B-8E0E-606C1D5BC36B%Не правильное прошлое$Получать%Get - got - got%rus_eng%7FA42C2E-28E0-4A75-B3AF-891BF91321AD%Не правильное прошлое$Он сдержал свое слово.%He kept his word.%rus_eng%80121E65-AD1B-4F76-9F4E-6B82F49F2D9A%Не правильное прошлое$Я поеподовал англ%I taught English%rus_eng%81631459-14DA-41BB-978D-8F1DD9998AC1%Не правильное прошлое$Я плавал в бассейне.%I swam in the swimming pool.%rus_eng%81C95C0B-57EF-48F4-9635-F1C5454EB9B0%Не правильное прошлое$Он упал на землю и ушиб свою руку.%He fell on a ground (He fell down) and hurt his arm.%rus_eng%83CBA743-80F1-4427-B204-A588AD4C1B10%Не правильное прошлое$Становиться%Become - became - become%rus_eng%84B64569-FA26-4224-94B0-5D7395A788BD%Не правильное прошлое$Находить%Find - found - found%rus_eng%85D2879F-C4AC-4155-A539-5B11194B3709%Не правильное прошлое$Она чувствовала себя расстроеной.%She felt upset.%rus_eng%86887957-B72C-4EA4-9A2F-7897EED5CD98%Не правильное прошлое$Я сел в кресло.%I sat in a armchair.%rus_eng%87298F6F-69A8-4CBC-B385-7F4FFC038EC8%Не правильное прошлое$Пить%Drink drank drunk%rus_eng%881B3424-429D-4514-BADC-B70C9EC62C02%Не правильное прошлое$Он задел ее чувства.%He hurt her feelings.%rus_eng%88E267EC-D387-4936-BC5C-589DFA3C6F12%Не правильное прошлое$Преодолевать%Overcome - overcame - overcome%rus_eng%8A04C244-3F83-4054-BCB4-1728C35BE737%Не правильное прошлое$Он сделал открытие.%He made a discovery.%rus_eng%8AD58E65-EC00-4D0E-B6E3-6416CBF21606%Не правильное прошлое$Сидеть%Sit - sat - sat%rus_eng%8E3349B6-A91D-4A3E-AB71-19F9125638DD%Не правильное прошлое$Он мог обьяснять очень сложные слова используя простые слова.%He could explain very difficult words using simple words.%rus_eng%8E4FDDCA-FE6C-449C-818B-1B6C2FFF0B6B%Не правильное прошлое$Я был горько разочарован.%I was bitterly disappointed.%rus_eng%8E73251A-24B8-4990-B60E-1728BA777E2E%Не правильное прошлое$Знать%Know- knew - known%rus_eng%8ECFA2D6-22C4-4307-80E4-AA0A5CEC90AA%Не правильное прошлое$Прощать%Forgive forgave forgiven%rus_eng%8EDEF047-D5BB-43C6-9C43-BB3072781BF9%Не правильное прошлое$Капать%Dig dug dug%rus_eng%8FF936B3-23FA-41CD-9D90-AF7CD92D2458%Не правильное прошлое$Я поехал в Россию.%I left for Russia.%rus_eng%9239003D-1714-4381-BC8C-6F7CE5C8D820%Не правильное прошлое$Показывать.%Show - showed - shown.%rus_eng%924A73AB-90A7-490A-9662-0A86FEF84392%Не правильное прошлое$Я выучил текст наизусть.%I learnt text by heart.%rus_eng%931A37FE-3F33-482F-8721-9D8219038C8F%Не правильное прошлое$Сделал%Make - made - made%rus_eng%95B09259-FDD4-4AD1-B274-AC6C0F14A7C7%Не правильное прошлое$Расти, выращивать%Grow grew grown%rus_eng%9643B88B-5B76-42EC-B111-F3EFA3577C63%Не правильное прошлое$Они продали свой загородный дом за 50 дол.%They sold their country house for 50 dollars%rus_eng%96C701A7-7EF5-4D3A-914A-E29981335BDC%Не правильное прошлое$Я услышал это в первые.%I heard it for the first time.%rus_eng%9715D42A-E61F-40F4-A71F-8E0333E440DC%Не правильное прошлое$Он украл ее сумку.%He stole her bag.%rus_eng%974F439B-8A31-4CB9-8489-FE1DF10DC33D%Не правильное прошлое$Она простила все%She forgave everything%rus_eng%9A39D6EB-F164-42B6-9E6A-0055E0C24F1D%Не правильное прошлое$Тратить%Spend spent spent%rus_eng%9B5C9B79-8921-46D1-BE9A-CB48B4D9CBCD%Не правильное прошлое$Петь%Sing sang sung%rus_eng%9B9D60E8-ACDB-486D-B528-ABB2103C4B6B%Не правильное прошлое$Давать%Give - gave - given%rus_eng%9E77788C-574A-4ABC-A0E6-E3AADEB4B83F%Не правильное прошлое$Падать%Fall fell fallen%rus_eng%9E81410F-9541-4EBD-ADEC-1BA837C930C7%Не правильное прошлое$Я забыл позвонить ей.%I forgot to call her.%rus_eng%A1EEB259-D49E-4A13-A6FC-4C452EF63F1C%Не правильное прошлое$Подходить%Fit fit fit%rus_eng%A27B4AB2-9457-471D-8456-904AF8F8C326%Не правильное прошлое$Приносить.%Bring - brought- brought.%rus_eng%A343EB31-8D50-43FB-B58C-D1482D6F9D92%Не правильное прошлое$Я имел дело с поставщиками%I dealt with suppliers%rus_eng%A53AE305-0F97-47FA-BCE1-3314511A4F62%Не правильное прошлое$Я встретил моего одноклассника вчера.%I met my classmate yesterday.%rus_eng%A62F2D65-198F-4804-BFDB-82C9E743DE59%Не правильное прошлое$Они встретились на конец%They met at last.%rus_eng%A6312F62-6B34-4D64-A559-7208EF346057%Не правильное прошлое$Я полетел назад в зп%I flew back to ZP%rus_eng%A6781D3A-1E24-4A3F-A4BD-205A2D17C567%Не правильное прошлое$Мечтать%Dream - dreamt - dreamt(может быть правильным dreamed)%rus_eng%A7C9BEBE-83D8-436D-9909-FBF59B56398E%Не правильное прошлое$Я забыл эту вещь полностью.%I forgot this thing completely.%rus_eng%A8136B3D-5354-41A3-9324-AFE0A5B47588%Не правильное прошлое$Я заплатил за нее%I paid for her.%rus_eng%A82567BF-E268-4188-B3CB-3EBB0C81850A%Не правильное прошлое$Она выращивала фрукт и овлщи в своем собственном саду.%She grew fruit and vegetables in her own garden.%rus_eng%A8327468-308B-45CA-8051-A30E9ACDC943%Не правильное прошлое$Драться%Fight fought fought%rus_eng%A8B2B878-6A42-4996-B23E-2D01F4DB1694%Не правильное прошлое$Я плавал в пруду.%I swam in the pond.%rus_eng%A95BE85E-DB8F-4727-A727-4521AAE1D934%Не правильное прошлое$Он ударил по мячу.%He hit the ball.%rus_eng%A96B29BF-103F-49FB-8AA6-8C375D709830%Не правильное прошлое$Есть%Eat ate eaten%rus_eng%ABE7494B-D149-43D5-952B-88ED03E5D331%Не правильное прошлое$Я думал по другому.%I thought differently.%rus_eng%AEBAD71F-D6E0-4729-81A5-0948DE945AD9%Не правильное прошлое$Позволить кому то что то сделать.%Let somebody do something.%rus_eng%AF7DE37E-510D-4C8A-AFC7-6AD266387561%Не правильное прошлое$Он порезался%He cut himself%rus_eng%AF8693A7-EA7E-4130-9CD5-5C2544AF042B%Не правильное прошлое$Урок начался два часа назад(пол часа назад).%The lesson began two hours ago. (half an hour ago)%rus_eng%B077AD75-8AE5-430A-BE13-DA7B14D5F570%Не правильное прошлое$Полиция поймала вора%The police caught the thief.%rus_eng%B16EC359-71BB-490D-BAD8-561AC7A777AA%Не правильное прошлое$Я мечтал о различных вещах.%I dreamt about different things.%rus_eng%B1B7C9DB-73AC-4A3C-B0DA-3E6119FCF561%Не правильное прошлое$Воровать%Steal stole stolen%rus_eng%B34CFE96-9067-45CC-9E07-ADB6127E432E%Не правильное прошлое$Я уехал с России.%I left Russia.%rus_eng%B5030252-B1BE-46A0-AF06-A5A694BFBCFE%Не правильное прошлое$Он преподал мне урок%He taught me a lesson%rus_eng%B5895CFA-EAB2-4B1D-8B70-4B2BBDEBE6D8%Не правильное прошлое$Основал очень прибыльную компанию.%He set up a very profitable company.%rus_eng%B9EBFDDA-D323-41BF-963A-E128C55F3121%Не правильное прошлое$Я подержал ее сумку.%I held her bag.%rus_eng%BAB10580-7EE6-482A-BC98-7C2EB5EBD9FF%Не правильное прошлое$Она купила очень просторную квартиру.%She bought a very spacious flat.%rus_eng%BDAF4ABD-6382-4F04-8F90-7D5C7BB8398C%Не правильное прошлое$Кормить%Feed fed fed%rus_eng%BDB643BE-6F11-48B5-9F6D-DC42D019004F%Не правильное прошлое$Он принес эту вещь мне.%He brought this thing to me.%rus_eng%BDEA611A-4804-47A4-AA3A-F5247988CA0C%Не правильное прошлое$Он бросил в нее камень%He threw a stone at her%rus_eng%BE28769B-C8CD-4217-9C46-F8B4D6EAA115%Не правильное прошлое$Эта пара обуви подошла мне.%This pair of shoes fit me.%rus_eng%BF930A83-0649-462A-9C8E-C65E0DBAB31E%Не правильное прошлое$Я нашел свой бумажник.%I found my wallet.%rus_eng%C02E5556-BF61-48EF-B296-06890A8E92EC%Не правильное прошлое$Я полежал в кровати%I lay in bed%rus_eng%C0ACDA5D-F364-4409-834D-EBB074BDBFF5%Не правильное прошлое$Она солгала мне%She lied to me%rus_eng%C1380BB8-1498-4891-BC6F-E7C2E2DF3DDB%Не правильное прошлое$Встреча началась на много позже.%The meeting began much later.%rus_eng%C168EF66-1C11-4A96-B661-1A38A3ADC848%Не правильное прошлое$Я стал позади его.%I stood behind him.%rus_eng%C1F7E73B-353A-44B0-B80A-4EEE57DBC554%Не правильное прошлое$Это был огромный(громадный) успех.%It was a huge(tremendous) success.%rus_eng%C29E3B25-79C5-4727-ABAA-FE42AE793FBE%Не правильное прошлое$Забывать%Forget forgot forgotten%rus_eng%C31181E6-4BCE-4790-80D7-E1A2B8460930%Не правильное прошлое$Он дал эту вещь.%He gave this thing.%rus_eng%C5D562F8-6AB2-4621-BEB9-663BE4490EAA%Не правильное прошлое$Иметь дело%Deal dealt dealt%rus_eng%C6731D2D-EB61-4B7E-B3F5-6766082FE4CB%Не правильное прошлое$Ломать%Break broke broken%rus_eng%C80D84CD-ED57-46FE-BF13-F9C500817447%Не правильное прошлое$Он сохранил этот секрет.%He kept this secret.%rus_eng%C8AAA4DF-F70F-482D-919E-90485791AA01%Не правильное прошлое$Одалживать.%Lend lent lent%rus_eng%C8E4BCB3-D59D-473F-B78F-5247C52A0A8F%Не правильное прошлое$Она потерял свои ключи.%She lost her keys.%rus_eng%CB9896B9-4B6B-4AC4-8A0D-1AB3333742FA%Не правильное прошлое$Плавать%Swim swam swum%rus_eng%D0E8469C-111C-4615-9BF6-82A53C4AF594%Не правильное прошлое$Я тоже думал так.%I also thought so.%rus_eng%D1B7B5DE-EE46-4108-952E-FA6C8ECCD8D5%Не правильное прошлое$Читать%Read - read - read (Рид - рэд - рэд)%rus_eng%D2E99931-2811-496F-8EC9-9BBCC38BC8D1%Не правильное прошлое$Он выпил стакан воды.%He drank a glass of water.%rus_eng%D35D77ED-F107-4B9B-9941-DF7E70306930%Не правильное прошлое$Урок начался вовремя.%The lesson began on time.%rus_eng%D88A34C3-7593-4B0B-957F-234E94F47C83%Не правильное прошлое$Дуть%Blow blew blown%rus_eng%D92419F4-E714-4153-BCC6-D17CD81725E2%Не правильное прошлое$Терять%Lose lost lost%rus_eng%D98837DB-BC0B-4973-8ED8-E24BCAE4E978%Не правильное прошлое$Она носила очень дорогую одежду%She wore very expensive close%rus_eng%DAAEB26F-C876-4FCF-8EFC-B96CEF524FDF%Не правильное прошлое$Мы покинули англию.%We left England.%rus_eng%DB41D309-133F-477B-BDCD-7D48D3F7BACF%Не правильное прошлое$Она отправила мне сообщение%She sent me a message%rus_eng%DCB70E7B-2A8F-45D3-AE1E-05710B5DBD46%Не правильное прошлое$Лежать%Lie lay lain%rus_eng%DDC69B5E-8F17-4AFC-9857-B2AB35F25363%Не правильное прошлое$Намеревался(две формы)%Meant & intended%rus_eng%DE9283DE-B055-43E6-A7DB-C00C4D5F1E58%Не правильное прошлое$Выяснять%Found out%rus_eng%E136ECAB-C165-4E0C-841F-96A7B0606FA6%Не правильное прошлое$Учить%Teach taught taught%rus_eng%E22ED12C-CAAA-49D4-A134-F4DF54B712A4%Не правильное прошлое$Выигрывать%Win won won%rus_eng%E3FEB8A7-2C43-472B-9522-6E90389D2A7E%Не правильное прошлое$Я проснулся раньше чем обычно.%I woke up early/later than usually.%rus_eng%E433F77E-0692-4A98-A3FE-CEB0F4DC7FFC%Не правильное прошлое$Бросать%Throw threw thrown%rus_eng%E4EAF8E1-B345-4A21-BC19-C4C9F9E109A9%Не правильное прошлое$Я мог слушать ее делая другие вещи.%I could listen to her doing other things.%rus_eng%E507FA90-EB1C-4175-8380-18B0128AC20A%Не правильное прошлое$Я выбросил это%I threw it away%rus_eng%E761C6BF-AEE3-4ECE-B3AF-AA9455A22D80%Не правильное прошлое$Я простил ее%I forgave her%rus_eng%E804A36A-EFA5-4381-89F7-67808F1D01A1%Не правильное прошлое$Я вырос в америкe.%I grew up in america.%rus_eng%E90E0651-3DF1-4987-BD51-361E7BBD69E5%Не правильное прошлое$Начинаться.%Begin - began - begun.%rus_eng%E96C78AD-E5CE-4ED9-A2F7-8A295CA3B306%Не правильное прошлое$Носить%Wear wore worn%rus_eng%ED57662E-2A29-4AF2-9E89-1BC93348A3CF%Не правильное прошлое$Я поспал достаточно.%I slept enough.%rus_eng%EE15CA8A-7507-46F0-B4BF-3D3F86162A6D%Не правильное прошлое$Я катался на лошаде.%I rode a horse.%rus_eng%F0207949-94D8-4297-8E21-2C78594FAA91%Не правильное прошлое$Он сказал это тихо/громко%He said it quietly/ loudly%rus_eng%F069920E-5DFF-4F58-A0F5-9524DD1FB033%Не правильное прошлое$Спать%Sleep slept slept%rus_eng%F06F1CAB-BD05-4483-8DE6-F2CEBBD683D3%Не правильное прошлое$Встать.%Stand - stood - stood%rus_eng%F10EB147-9F04-4421-A786-28F7C51A9DF0%Не правильное прошлое$Она пела очень красиво.%She sang very beautiful.%rus_eng%F4044B4C-5C6A-4561-BD93-292A78F5F341%Не правильное прошлое$Он сьел бутерброд.%He ate a sandwich.%rus_eng%F4BAC421-CEA8-43D0-A2BC-5BED478B65C2%Не правильное прошлое$Просыпаться%Wake woke woken%rus_eng%F4CFF286-C238-4921-B0D7-90EDBDD2B50B%Не правильное прошлое$Она ушибла руку%She hurt her arm%rus_eng%F68C4080-A274-4A72-96C7-B77CA6799767%Не правильное прошлое$Мальчик показал выдающиеся результаты.%The boy showed the outstanding results.%rus_eng%F924BEEB-635A-493A-884B-D0B1E3B1983D%Не правильное прошлое$Я получил емэйл от нее.%I got an email from her.%rus_eng%FC215D61-2A65-4817-A187-BE8E2FB63FAE%Не правильное прошлое$Мы преодолели те трудности%We overcame those difficulties.%rus_eng%FD5F9175-E878-4BDD-B9F3-3C5FB446BC74%Не правильное прошлое$Она покормила кота.%She fed the cat.%rus_eng%FD885D4C-E1C0-4252-932B-C60A3C765606%Не правильное прошлое$Поехал в%Left for.%rus_eng%FE500655-3CB9-4407-BFD7-AF62663AED71%Не правильное прошлое$Я мог учить англ часами.%I could learn English for hours.%rus_eng%FFCB72D4-4192-4EE6-BD2F-11AF8BB01D20%Не правильное прошлое$Почему ты против этого?%Why are you against it?%rus_eng%01F0BF9D-E768-4CB8-AD3F-173AF072A36C%Новые сложные слова$Этот результат впечатлит их?%Will this result impress them?%rus_eng%05BAFA9D-211A-468D-8C41-119F3EE5FD75%Новые сложные слова$Тестовый%Bla%rus_eng%753B381D-7349-4217-9E97-783BC492CBCD%Новые сложные слова$Мне кажется день не будет дождливым.%It seems to me the day won\'t be rainy.%rus_eng%CE40E116-66B4-486F-AC9B-E66C239A1F8A%Новые сложные слова$Я ненавидел обсуждать это.%I hated discussing it.%rus_eng%01A30AF8-57B5-42A6-BE5F-2EFBCCA711CF%Прошлое время$Тщательно%Thoroughly%rus_eng%06235067-8662-4678-B66E-EABBBC5B21AA%Прошлое время$Вор%Thief%rus_eng%0BCE3527-0596-4895-A96F-568CCA04682C%Прошлое время$Она предложила пойти в кино.%She suggested going to the cinema.%rus_eng%0C3DABDF-92C3-49C8-BE35-A3CA23875E7A%Прошлое время$Я разделил это на 3 части.%I divided it into three parts.%rus_eng%0EA96453-0471-4EA5-9910-240E4769B121%Прошлое время$Я решил сделать это.%I decided to do it.%rus_eng%1A1C1DE0-6ACB-4D43-8264-3FCB7C6EF0C1%Прошлое время$Это привлекло наше внимание.%It attracted our attention.%rus_eng%1C10898E-060E-43B2-BC81-FF536A3D0C24%Прошлое время$Он умыл свое лицо.%He washed his face.%rus_eng%206A583C-AC44-4125-8A06-B140B4203F4B%Прошлое время$Он обещал нам сдержать свое слово.%He promised us to keep his word.%rus_eng%2614D49E-BA87-494C-B9C7-F08F6DAAE1C1%Прошлое время$Мы переехали в лондон.%We moved to London.%rus_eng%2A326A3C-F50A-4DBB-9BED-6F9FE4678165%Прошлое время$Он перепрыгнул через забор.%He jumped over the fence.%rus_eng%2A4BAC58-E508-4919-B2F3-67DB3F24265D%Прошлое время$Он открыл америку.%He discovered America.%rus_eng%2B2AD813-5BA6-4C91-9252-D5DE86BF8469%Прошлое время$Его речь вдохновила нас.%His speech inspired us.%rus_eng%2C4ECC2B-1D46-4920-985B-F384FECE217C%Прошлое время$Мы доверяли ему полностью.%We trusted him completely.%rus_eng%361F45B5-E592-4125-A397-6C3147C51844%Прошлое время$Она описала эту ситуацию.%She described this situation.%rus_eng%370AE26B-41DA-4970-A5A7-4701F1FB5217%Прошлое время$Она описал ее внешность.%She described her appearance.%rus_eng%37A6E14A-4526-409F-A1F0-ABCD3662CD1A%Прошлое время$Он пересек улицу.%He crossed the street.%rus_eng%3E26C4C9-93D8-47D1-9AA1-D62779F892BE%Прошлое время$Он обычно молился утром.%He usually prayed in the morning.%rus_eng%4143E6B9-67CB-4D84-880E-EE4E180F0A9F%Прошлое время$Мой двоюродный брат пожалел об этом.%My cousin regretted it.%rus_eng%41C88BBA-E969-490C-8518-6109D349B74A%Прошлое время$Она помыла посуду.%She washed up the dishes.%rus_eng%41F61512-1B41-4CA0-91EF-22363A72C26D%Прошлое время$Я заполнил эти документы.%I filled in these documents.%rus_eng%454DB950-A521-46CA-8CCA-5C47E2FF45FF%Прошлое время$Он испытал так много трудностей.%He experienced so many difficulties.%rus_eng%46995DF4-A881-4B6E-B0BC-17AE6953B152%Прошлое время$Я включил/выключил компьютер.%I turned on/off the computer. I switched on/off the computer.%rus_eng%4B6BC4DD-1694-4583-9E69-4DBFB53CF748%Прошлое время$Она упустила ту возможность.%She missed that opportunity.%rus_eng%4FC51214-BDD4-48E3-B4F9-4D6E68441555%Прошлое время$Предлагать делать что то.%Suggest doing something.%rus_eng%51F449B2-E54C-4D21-8A68-FE74C7AE205E%Прошлое время$Я сконцентрировался на этой теме.%I concentrated on this topic.%rus_eng%53B463C6-F72D-4385-8C27-7DB1D84DD6D9%Прошлое время$Я желаю вам большого успеха. Я чувствую вы этого заслуживаете.%I wish you a huge success.  I feel you deserve it.%rus_eng%54AA500B-16B0-484A-92BE-B6088E5CDF27%Прошлое время$Там часто идет дождь/снег.%It often rained/snowed there.%rus_eng%5592CFCC-53F7-47B0-AF97-2570424DB43C%Прошлое время$Мы столкнулись с очень большой проблемой.%We faced a very big problem.%rus_eng%56BBCB73-50EA-42E1-9C9A-A3ADA90577EC%Прошлое время$Он приказал солдатам сделать это.%He ordered the soldiers to do it.%rus_eng%56D3A811-35AB-4F6B-BB97-3CAF61D24D9A%Прошлое время$Мы пошли в парк.%We walked to the park. We went to the park on foot.%rus_eng%58B08827-67EB-4344-8CE4-7C940A640E3C%Прошлое время$Он подтвердил свое решение.%He confirmed his decision.%rus_eng%5966BC98-1940-45E7-812F-C2838C214D91%Прошлое время$Мы поторопились.%We hurried up.%rus_eng%5BF4270C-4541-4BF8-9CAF-562932A80002%Прошлое время$Урок длился 2 часа.%The lesson lasted for 2 hours.%rus_eng%5E17D514-7DD8-4B3A-8D7F-A5D1FA185934%Прошлое время$Это произошло случайно.%It happened by accident. (accidentally)%rus_eng%644FE096-C8D5-4AC6-AD46-1905F0DEA8E3%Прошлое время$Он настоял чтобы сделать это.%He insisted on doing it.%rus_eng%6521FD30-ABAE-403B-9EFB-9CCA236B7072%Прошлое время$Враг атаковал их.%The enemy attacked them.%rus_eng%6BE41CD8-1BAC-4EE4-AC8C-A3F132AF66E1%Прошлое время$Это привлекло наше внимание сразу же.%It attracted our attention immediately /  at once.%rus_eng%6ECBEA5C-DFC3-432B-93D7-5F484B523862%Прошлое время$Я надеялся получить ту работу.%I hoped to get that job.%rus_eng%6FE15CD5-2349-4DFB-A49C-26BB30C6B4B3%Прошлое время$Я ответил на следующие вопросы.%I answered the following questions.%rus_eng%7404F88B-90E9-4588-95A7-79E03FE007C1%Прошлое время$Мы склоны были считать это очень важным.%We tented to consider it very important.%rus_eng%762251BC-5903-480B-AF7B-21EB2D99A9EF%Прошлое время$Я въехал/выехал туда в 3 часа дня.%I checked in/out at 3 o\'clock in the afternoon.%rus_eng%768ECEF5-F6E8-42DB-B58F-5B7198660C9D%Прошлое время$Он настаивал на этом.%He insisted on it.%rus_eng%7AC8016D-C035-468B-896D-43A188BE247F%Прошлое время$Он помолился святым.%He prayed to saints.%rus_eng%7AFF2619-A6D2-4629-8F3C-4E1FD594067D%Прошлое время$Он приказал защищать их.%He ordered to defend them.%rus_eng%7E10D4D1-5928-4931-9ADD-52CBDAAFCA42%Прошлое время$Они исчезли неожиданно.%They disappeared unexpectedly.%rus_eng%7F3EB775-E6CF-45F9-8A74-5735142FE205%Прошлое время$Мне нужно было связаться с ней.%I needed to get in touch with her.%rus_eng%8117AA9D-92D9-4029-BBC3-562A11AA7930%Прошлое время$Они отпраздновали свою годовщину.%They celebrated their anniversary.%rus_eng%8363B06B-B394-4B2A-BE60-E2210B4F4406%Прошлое время$Мы включили его имя.%We included his name.%rus_eng%864DE476-8977-4909-B2B9-88B32B609E74%Прошлое время$Мы ожидали эти результаты.%We expected these results.%rus_eng%86803BB7-1E2A-4CA9-A45D-195FC644F1AF%Прошлое время$Он подтвердил дату нашей встрече.%He confirmed the date of our meeting.%rus_eng%871182E7-AE95-48F4-8271-3ADE0A628943%Прошлое время$Я пожелал ему удачи.%I wished him good luck.%rus_eng%8DECECA4-52DF-4642-996B-D545E10F69F5%Прошлое время$Он воображал различные вещи.%He imagined different things.%rus_eng%8F807F02-6FC5-4ABE-9A5A-EAF22DA48F95%Прошлое время$Он заслуживал это.%He deserved it.%rus_eng%91BF169A-9D7B-4FF8-B440-B2A5D182CD13%Прошлое время$Он отрицал свою вину.%He denied his guilt.%rus_eng%91C33C0F-A5A8-412A-80A5-3C14E9BA9D62%Прошлое время$Его поведение казалось очень подозрительным.%His behave seemed very suspicious.%rus_eng%932FB908-C994-44D8-9494-4000ABF2B234%Прошлое время$Мы считали эту победу очень важной.%We considered this victory very important.%rus_eng%97234D7D-D0A0-42C2-AE1B-62DA0DB44EF4%Прошлое время$Я припарковался там.%I parked there.%rus_eng%98E2F978-B5F1-434E-82F0-C410D38D0B19%Прошлое время$Они обвенили его в этом преступлении.%They accused him of this crime.%rus_eng%9AE0C3F3-C25F-4778-845D-52844F2F0157%Прошлое время$Он курил достаточно редко.%He smoked quiet rarely.%rus_eng%9BDE0719-5FDA-4A4D-8178-95E9A3CF5A2D%Прошлое время$Они предложили пойти в кино.%They suggested going to the cinema.%rus_eng%9DD8DEC3-9341-4FA9-87A3-2B58BE25E379%Прошлое время$Я достиг этого результата.%I reached this result.%rus_eng%9F50732B-B1E5-4898-A730-4C1D9EC5464E%Прошлое время$Они обеспечивали очень хорошие условия.%They provided very good conditions.%rus_eng%A0CFC6C2-0370-4068-BCB9-B60415CC2A23%Прошлое время$Он постучал в дверь.%He knocked at/on the door.%rus_eng%A24EEE0A-31F5-4095-8291-5151A459F279%Прошлое время$Мы конкурировали с несколькими большими компаниями.%We competed with several big companies.%rus_eng%A351766E-4BA3-4E5A-98AC-7DEACCD412C7%Прошлое время$Он курил очень редко.%He smoked very rarely/seldom.%rus_eng%AC973C90-0DF0-4509-BE3F-29E1D77B354F%Прошлое время$Этот дом принадлежал ей.%This house belonged to her.%rus_eng%ADFB8305-A29F-41D7-9A52-A525CB92850C%Прошлое время$Они производили очень дорогие товары.%They produced very expensive goods.%rus_eng%AFC52128-FF29-4FEF-BFB0-BEF3EEEB9E62%Прошлое время$Я часто был не согласен с ними без какой либо причины.%I often disagreed with them for no reason.%rus_eng%B1A2A509-C959-4AA3-B9EE-129DFEB0FC3D%Прошлое время$Все осталось таким же.%Everything remained the same.%rus_eng%B7840767-A9AF-4884-B1AE-64AC6AA1E9E0%Прошлое время$Это событие повлияло на меня.%This event influenced on me.%rus_eng%BA7E003F-FFA6-4F4D-9F6D-67502D3EFB9F%Прошлое время$Я представил его им.%I introduced his to them.%rus_eng%BB4C763B-80BD-4BA0-8FDA-9AD38FE5189D%Прошлое время$Мы считали это очень важным.%We considered it very important.%rus_eng%BD5A6DE9-985D-4D9F-B6B7-318A2E7E1D78%Прошлое время$Он повернулся и улыбнулся ей.%He turned and smiled at her.%rus_eng%BD9CA73A-092D-4CB6-8FC0-EAB7EBD73411%Прошлое время$Его поведение казалось очень подозрительным.%His behave seemed very suspicious.%rus_eng%BFE880FA-B59A-4F07-AEBD-4C71BCD74B70%Прошлое время$Она частично согласилась со мной.%She partly agreed with me.%rus_eng%C05F362D-0B70-4F0B-A90E-CF0AD3628BF3%Прошлое время$Мальчики вели себя очень плохо.%The boys behaved very badly.%rus_eng%C1896CAE-851D-4FF6-B20F-B1A12FC199A1%Прошлое время$Он вошел в сдание.%He entered the building.%rus_eng%CA66326D-E702-4A72-8FE2-E4549728CCA0%Прошлое время$Мы упаковали эту посылку. %We packed this parcel.%rus_eng%D397AEC5-92D5-476A-AA1E-92FBBB96DB5F%Прошлое время$Они предложили нам что то особенное.%They offered us something special.%rus_eng%DA096C69-E304-4A4B-AD88-9A461B87E0E9%Прошлое время$Тот мужчина спас ее жизнь.%That man saved her life.%rus_eng%DF3BECB3-734D-4BD2-AA20-2755A8F7CF6A%Прошлое время$Они исчезли вдруг.%They disappeared suddenly.%rus_eng%E320AEEB-5A1B-4D82-ADFC-8503B4907AE6%Прошлое время$Это требовало больше усилий.%It required more efforts.%rus_eng%E3278226-CEC6-44D8-9197-9CDBF90F4A12%Прошлое время$Он заработал больше чем 500 долларов.%He earned more than 500 $%rus_eng%E39FB364-D408-445F-9A16-5F3D88EE5BF6%Прошлое время$Он пригласил нас на свое день рождение.%He invited us to his birthday.%rus_eng%E417429C-9EAD-4EFB-BA89-F9A3630C8E40%Прошлое время$Они разрушили сдание.%They destroyed the building.%rus_eng%E56146AA-D0E9-4F27-9D4A-9F238DBD53D6%Прошлое время$Он отрицал все обвинения.%He denied all the accusations.%rus_eng%E5A61629-5F90-4424-AD3F-A1FA453EB1FA%Прошлое время$Они предложили мне высокооплачиваемую работу.%They offered me a well-payed job.%rus_eng%E8DA58CD-4E4D-4621-BB69-C6F38F8DCF7C%Прошлое время$Я упомянул это во время нашего разговора.%I mentioned it during our conversation / talk.%rus_eng%EFD45DC9-061B-4A62-840D-4FB2A892D8EA%Прошлое время$Я повторил твои уроки еще раз.%I revise your lessons one more time.%rus_eng%F764BEB0-5719-46C6-BF05-EFC79B68C995%Прошлое время$Я пользовался интернетом практически каждый день.%I used the internet almost every day.%rus_eng%F7772EED-BA6F-4FF1-ABDF-701EDE9F7ECF%Прошлое время$Я остался спокойным.%I remained calm.%rus_eng%F82583ED-7DB2-48A2-9EDB-D73FEFBC2FA7%Прошлое время$Она задала ему пару вопросов.%She asked him a couple of questions.%rus_eng%F882B4D5-1982-4630-B462-4D6130DEBD70%Прошлое время$Я склонен был думать так.%I tented to think so.%rus_eng%F97192DA-C83C-46A7-ABF4-0E6894F12676%Прошлое время$Он перебил наш разговор.%He interrupted our conversation/ talk.%rus_eng%FD192889-C6E3-40ED-81D1-806E2FBF7C08%Прошлое время$Он пожалел об этом.%He regretted it.%rus_eng%FE9B71CC-3C57-4F90-B448-3C0C9628C3F1%Прошлое время$Они убивали невинных людей.%They killed innocent people.%rus_eng%FF447FC3-82A7-4D1F-A71F-3D62CC46067C%Прошлое время$Это изменило мое отношение к ней.%It change my attitude to her.%rus_eng%FFB8345E-25EF-4E31-84B7-5BB985D35395%Прошлое время$Услышать.%Hear - heard - heard.%rus_eng%03838320-849F-4BD9-AFFF-F6948A5EE02C%Слова прошлое (не правильное)$Приносить.%Bring - brought- brought.%rus_eng%03864C3B-5E2E-488E-A3E2-63B5C54074C6%Слова прошлое (не правильное)$Бросать%Throw threw thrown%rus_eng%07422A50-1CB4-40E0-BCB5-71FAFDA4EA41%Слова прошлое (не правильное)$Находить%Find - found - found%rus_eng%14F43BCB-CB98-41F1-AAAB-11DCA81A078F%Слова прошлое (не правильное)$Есть%Eat ate eaten%rus_eng%15EC9506-552C-498F-BCAE-1EBEC82C215D%Слова прошлое (не правильное)$Воровать%Steal stole stolen%rus_eng%1824DACF-3CAA-4B1E-B87D-6DAE91C72934%Слова прошлое (не правильное)$Значит.%Mean - meant - meant.%rus_eng%1AABD4F0-5E42-4176-AB5E-8F5DBE34ABEC%Слова прошлое (не правильное)$Становиться%Become - became - become%rus_eng%1DB5583C-73C2-4A7D-BDA6-D71CD775B866%Слова прошлое (не правильное)$Капать%Dig dug dug%rus_eng%239C98BF-7A60-4B57-8794-632DFC8409D5%Слова прошлое (не правильное)$Мечтать%Dream - dreamt - dreamt(может быть правильным dreamed)%rus_eng%25FCD488-D2A7-43A8-832F-2E55AEE84FA1%Слова прошлое (не правильное)$Хранить%Keep kept kept%rus_eng%2CE8D65C-52CF-414F-A864-A161F6AE22DC%Слова прошлое (не правильное)$Выяснил%Found out%rus_eng%3155D895-FD9C-45FC-AAAF-C19BF20678EE%Слова прошлое (не правильное)$Преодолевать%Overcome - overcame - overcome%rus_eng%3185187B-290C-4591-B6A3-15788817A932%Слова прошлое (не правильное)$Поставить%Lay laid laid(set, put)%rus_eng%398AE249-0606-46C6-AB3D-B6C33C27AECE%Слова прошлое (не правильное)$Позволять.%Let - let - let.%rus_eng%3BDDB107-D69B-47B4-B7FA-51F4B71D0EB1%Слова прошлое (не правильное)$Лгать%Lie lied lied%rus_eng%419470F1-4461-4D50-ACDC-8165D22C02C9%Слова прошлое (не правильное)$Давать%Give - gave - given%rus_eng%45C1D531-1E1B-497F-B7C0-4F07151D21D9%Слова прошлое (не правильное)$Показывать.%Show - showed - shown.%rus_eng%4B0291FA-C735-4D60-8EED-D3167A9FDA0E%Слова прошлое (не правильное)$Иметь дело%Deal dealt dealt%rus_eng%4B5EF7AF-F8B5-4410-B84C-C42C8CA1AFC8%Слова прошлое (не правильное)$Встать.%Stand - stood - stood%rus_eng%4C95A8C9-A205-4928-BBEE-7003549F0FDA%Слова прошлое (не правильное)$Думать%Think - thought- thought%rus_eng%4D33412A-4030-4D8F-A450-DC648B993477%Слова прошлое (не правильное)$Драться%Fight fought fought%rus_eng%52300E37-3CC9-42F6-AFC5-68EF3AC41A7E%Слова прошлое (не правильное)$Сидеть%Sit - sat - sat%rus_eng%58BCD8DD-4C3C-47FA-9167-12567C0FD470%Слова прошлое (не правильное)$Терять%Lose lost lost%rus_eng%59D0F2AB-1150-4BDE-B575-303143FD46F1%Слова прошлое (не правильное)$Читать%Read - read - read (Рид - рэд - рэд)%rus_eng%5CA7088F-FC34-48A8-AF49-959336EEACE0%Слова прошлое (не правильное)$Держать(руками например)%Hold held held%rus_eng%5E43F525-3870-47F0-A319-C7277568D260%Слова прошлое (не правильное)$Тратить%Spend spent spent%rus_eng%63526092-A631-4D91-BE0E-E95103E16171%Слова прошлое (не правильное)$Кататься%Ride rode ridden%rus_eng%6D93EA3C-EE41-4E9B-AD40-EA108B56477B%Слова прошлое (не правильное)$Учить%Learn learnt learnt Learned learned%rus_eng%6E5895B6-D095-4CA1-892A-5FD97D5B20AC%Слова прошлое (не правильное)$Покидать.%Leave - left - left.%rus_eng%6EE5510C-54D7-4217-A762-F3FB7D7E61B1%Слова прошлое (не правильное)$Лежать%Lie lay lain%rus_eng%7454B1DF-5E58-4794-806A-3C60B9610ACA%Слова прошлое (не правильное)$Прятаться%Hide hid hidden%rus_eng%76B8A4C6-1920-4FD1-9092-CF37B03EDA9B%Слова прошлое (не правильное)$Одалживать.%Lend lent lent%rus_eng%79718F03-5F19-40C0-B478-995F7A2BB061%Слова прошлое (не правильное)$Ставить%Put - put - put%rus_eng%7B546C83-7BFE-4E88-A8F9-62A7171DDA9D%Слова прошлое (не правильное)$Начинаться.%Begin - began - begun.%rus_eng%7BB35FB3-D2B2-4E07-9089-8546705E22F7%Слова прошлое (не правильное)$Отправлять%Send sent sent%rus_eng%7C22848D-200F-473B-B08F-35CFDAEEC815%Слова прошлое (не правильное)$Расти, выращивать%Grow grew grown%rus_eng%8430AB5E-6B38-4AA3-AC2B-07081821AB51%Слова прошлое (не правильное)$Встречать%Meet - met - met%rus_eng%8670F7C7-AE33-4779-88D1-E6EF7130D9EC%Слова прошлое (не правильное)$Продовать%Sell sold sold%rus_eng%8AEEB4D4-1CC5-46CF-83D8-66A643965A02%Слова прошлое (не правильное)$Дуть%Blow blew blown%rus_eng%8E22B73B-6FC7-4891-8995-7444CA30259C%Слова прошлое (не правильное)$Учить%Teach taught taught%rus_eng%8ED591FB-7B0B-4881-BE95-EBE3D8856A06%Слова прошлое (не правильное)$Прощать%Forgive forgave forgiven%rus_eng%90121CFE-74C4-4B5D-A137-0FD3851753ED%Слова прошлое (не правильное)$Ломать%Break broke broken%rus_eng%9632C04D-805A-4BD2-8229-8B9B17EAB266%Слова прошлое (не правильное)$Поставил, установил%Set set set%rus_eng%96BD2025-38A4-45F9-ACFA-DC5060269DE8%Слова прошлое (не правильное)$Сказать кому то%Tell - told - told%rus_eng%986B6032-F138-44DD-834E-1ACFC204C56F%Слова прошлое (не правильное)$Ловить%Catch - caught caught%rus_eng%99BF6FA7-8580-48B9-8F78-DAF9858CCB10%Слова прошлое (не правильное)$Выигрывать%Win won won%rus_eng%9DAE242E-FD5D-4F65-B7B9-8AE1DDADD38A%Слова прошлое (не правильное)$Пить%Drink drank drunk%rus_eng%9E1551D5-33F9-41E2-9A85-3FEB0157AAF9%Слова прошлое (не правильное)$Купить%Buy bought bought%rus_eng%A3B9DE84-A104-4986-B9FF-285893F1C955%Слова прошлое (не правильное)$Могу%Can - could%rus_eng%A5599F34-102F-45A4-8077-7EC4C925618D%Слова прошлое (не правильное)$Бежать%Run ran run%rus_eng%A5FD136B-F8F1-4C67-991E-BC67F493547F%Слова прошлое (не правильное)$Просыпаться%Wake woke woken%rus_eng%A8B4A75E-FE43-45EB-81DD-20AD193A7E09%Слова прошлое (не правильное)$Сделал%Make - made - made%rus_eng%A92082CB-2281-4B4E-A3D5-8B35D768ED89%Слова прошлое (не правильное)$Понимать%understand - understood - understood%rus_eng%AAD56546-0D01-4F5D-B573-9CBD2DE1DEFB%Слова прошлое (не правильное)$Получать%Get - got - got%rus_eng%AE223936-8D33-4F40-B86F-BD8D8DFCF40E%Слова прошлое (не правильное)$Ушибить, задеть%Hurt hurt hurt (injured правильная форма)%rus_eng%AE64E8D7-4EF3-4EF6-B611-0DBA68CD4238%Слова прошлое (не правильное)$Плавать%Swim swam swum%rus_eng%BC9D93BA-F353-447B-ABA9-B3CFF150E257%Слова прошлое (не правильное)$Ударить%Hit hit hit%rus_eng%BDB0AB9C-B608-487F-A258-06BB8B5EA90F%Слова прошлое (не правильное)$Петь%Sing sang sung%rus_eng%C801F970-8E67-4056-9FA6-1B4F2BD74934%Слова прошлое (не правильное)$Забывать%Forget forgot forgotten%rus_eng%CBE5DD2B-38DD-44B3-9BCA-904AFDA7B1FC%Слова прошлое (не правильное)$Спать%Sleep slept slept%rus_eng%CF52F92A-3078-4688-AAB9-C377FA6DA206%Слова прошлое (не правильное)$Кормить%Feed fed fed%rus_eng%D3FCFA48-280B-45EB-8C8B-71C599887760%Слова прошлое (не правильное)$Чувствовать%Feel - felt - felt%rus_eng%D54D21AC-38D8-4CF2-9474-6145566626FA%Слова прошлое (не правильное)$Писать.%Write - wrote - written.%rus_eng%D6BC7F3C-AB28-483B-8235-50EE925826F4%Слова прошлое (не правильное)$Летать%Fly flew flown%rus_eng%D8B435EF-41D9-438D-B6AF-A6EE1897BAD4%Слова прошлое (не правильное)$Быть%Be, was - he, she, it, were%rus_eng%E18811AD-EF4D-40EA-8B7E-EA1F4BF5338E%Слова прошлое (не правильное)$Подходить%Fit fit fit%rus_eng%E18C9A2D-9CAD-424A-9D62-D53A535FD178%Слова прошлое (не правильное)$Носить%Wear wore worn%rus_eng%E1C183F1-3B17-4224-90D0-85D2D6352871%Слова прошлое (не правильное)$Падать%Fall fell fallen%rus_eng%E4A8FDF8-EA23-49B4-993E-EA96758D95FA%Слова прошлое (не правильное)$Рисовать%Draw drew drawn%rus_eng%EA762BCA-FE20-4743-8979-3EBD706DC980%Слова прошлое (не правильное)$Знать%Know- knew - known%rus_eng%ED5AA31D-C259-4155-A014-425137FD5C6C%Слова прошлое (не правильное)$Идти%Go - went - gone%rus_eng%EFBFB2D4-7528-4E12-A3DA-FC1471637DB6%Слова прошлое (не правильное)$Платить%Pay paid paid%rus_eng%F2EE3D19-CAFB-427B-917B-F3C9A7692F23%Слова прошлое (не правильное)$Резать%Cut - cut - cut%rus_eng%F3744556-1A30-4431-A09D-8BD0EC53E724%Слова прошлое (не правильное)$Сказать -%Say - said - said%rus_eng%F7E4CAA8-1BCB-4B1B-BE2D-EE653996269C%Слова прошлое (не правильное)$Меры%Measures%rus_eng%0728A9EC-C865-4909-BF64-1100BBEE53F7%Сложное написание$Неудобный.%Inconvenient.%rus_eng%2C22AFE4-7098-4D14-8E51-D9DA0535F56C%Сложное написание$Принимать серьезные меры.%Take serious measures.%rus_eng%C21153C7-4C52-46C8-AF46-D7AF9C250E9B%Сложное написание$Они будут вести себя более осторожнее.%They\'ll behave more carefully.%rus_eng%028EAAF9-F877-4709-B98A-6E21A2510195%Тяжелые$Неудобный.%Inconvenient.%rus_eng%04C13020-ED0C-4E9B-9076-A32660CEAF71%Тяжелые$Как долго твои родители будут отсутствовать?%How long will your parents be away?%rus_eng%06BFBF0F-646F-45FB-8F58-968E75C52AB3%Тяжелые$Он не будет курить больше.(дольше)%He won’t smoke anymore.(any longer)%rus_eng%0790BEEA-2E2C-444E-8006-652F1C4A6F4D%Тяжелые$Это требовало больше усилий.%It required more efforts.%rus_eng%09B38EA0-80C2-42BA-A72F-0747527FDCD8%Тяжелые$Они обвенили его в этом преступлении.%They accused him of this crime.%rus_eng%11210983-757E-4320-8CC4-A250B9D2832E%Тяжелые$Это не принесет тебе больше денег.%It won\'t bring you more money.%rus_eng%132809CE-6CEB-45D2-B3AD-352354BDCDB8%Тяжелые$Это произошло случайно.%It happened by accident. (accidentally)%rus_eng%18E96CC4-9620-43AF-8CB5-4EE5155FE081%Тяжелые$Он подтвердил свое решение.%He confirmed his decision.%rus_eng%1B1C9976-F751-44C0-BEF6-F92EBDB31C2C%Тяжелые$Этот подход не будет достаточно инновационным.%This approach won\'t be innovative enough.%rus_eng%1FA9DDCD-16FD-4985-B0CF-9FAE50B0BC8A%Тяжелые$Он курил достаточно редко.%He smoked quiet rarely.%rus_eng%21CEB6AE-1A20-4420-A55C-CDCA59FCA25A%Тяжелые$Я думаю нам не нужно изобретать заново колесо.%I think we don\'t need to reinvent the wheel.%rus_eng%2C49FA5D-A349-40FB-8C72-292EF1E1F323%Тяжелые$Это будет длиться вечно?%Will it last forever?%rus_eng%2D377FEB-549B-4E1A-90BE-810D29143D6B%Тяжелые$Все осталось таким же.%Everything remained the same.%rus_eng%2D90FD92-64C9-4E29-9031-C843E53B85CD%Тяжелые$Мы склоны были считать это очень важным.%We tented to consider it very important.%rus_eng%30B91A37-0FE5-418D-AE6B-87F38A0E0BC7%Тяжелые$Учитель простит ему.%The teacher will forgive him.%rus_eng%3380DDF6-EBF7-4595-84EF-438B8F76CAAB%Тяжелые$Каким видео ты восхищаешься больше?%Which video do you admire more.%rus_eng%38AE7C1C-9EBC-4A7B-A482-72D528AD62CE%Тяжелые$Я повторил твои уроки еще раз.%I revise your lessons one more time.%rus_eng%3D4DF2CF-6AB3-49AD-A4DE-A9ED555AA557%Тяжелые$Они отпраздновали свою годовщину.%They celebrated their anniversary.%rus_eng%445D80E3-A18F-4CC5-A17C-8E5529F925D2%Тяжелые$Она упустила ту возможность.%She missed that opportunity.%rus_eng%4742991A-8F92-42E3-A36E-D827547227FF%Тяжелые$Студенты посмотрят это в словаре?%Will the students look it up in a dictionary?%rus_eng%4AE6BDAF-124F-4994-A16B-654B0BEACD24%Тяжелые$Этот результат впечатлит их?%Will this result impress them?%rus_eng%51086C73-3065-435E-8876-E58890B7752F%Тяжелые$Принимать серьезные меры.%Take serious measures.%rus_eng%645399F9-DC28-42E7-902E-963E5112B48A%Тяжелые$Он отсутствует.%He is away.%rus_eng%6554A6FB-0602-4993-9AEA-EBB19C92A9F1%Тяжелые$Я сумею удвоить наши продажи, не смотря на кризис.%I\'ll manage to double our sales, despite (in spite of) the crisis.%rus_eng%6D7CD0AC-B9BC-4D89-B7C0-2AD0A6078B7A%Тяжелые$Мой бизнес партнер отдолжит ему эту сумму денег.%My business partner will lend him this sum of money.%rus_eng%6FAE28CC-D9D3-40BA-B5E7-12018AF091DF%Тяжелые$Это событие повлияло на меня.%This event influenced on me.%rus_eng%760C8584-15CA-4285-99AF-ECC066BD5E53%Тяжелые$Привести к успеху.%Lead to success.%rus_eng%7F12934D-AF8E-4DDC-8547-DFAADC2BC7A4%Тяжелые$Я желаю вам большого успеха. Я чувствую вы этого заслуживаете.%I wish you a huge success.  I feel you deserve it.%rus_eng%8454B823-6FA9-474D-83D6-1D6864C71CD2%Тяжелые$Я думаю он будет обожать спорт, но это не обязательно означает, что он станет профессиональным спортсменом.%I think he\'ll fond of sport but it doesn\'t necessarily mean that he\'ll became a professional sportsman.%rus_eng%94C4BBCC-5F51-4639-8405-E8B824A107EB%Тяжелые$Он настоял чтобы сделать это.%He insisted on doing it.%rus_eng%9737BFE6-EEFA-4416-BEF8-EC1A596B795E%Тяжелые$Он приказал защищать их.%He ordered to defend them.%rus_eng%A2AF9A84-3703-4386-91BC-D57F81FF839A%Тяжелые$Они убивали невинных людей.%They killed innocent people.%rus_eng%A5C09E90-14B6-4264-8274-3ACE6C36C7AA%Тяжелые$Мой босс не будет настраиваться на это.%My boss won\'t insist on it.%rus_eng%AB99EB12-2F02-4531-82FA-83A0F00D6E8E%Тяжелые$Жизнь накажет его.%Life will punish him.%rus_eng%AD036211-068E-43F5-9363-59703684940E%Тяжелые$Я постараюсь не делать это.%I\'ll try not to do it.%rus_eng%B00BCC15-7626-4DF4-A208-481128827D8A%Тяжелые$Сколько денег ее муж будет должен им?%How much money will her husband owe them?%rus_eng%B449ED10-533D-457F-887F-A0968C3580C5%Тяжелые$Это наш последний шанс.%It\'s our last chance. (чанс)%rus_eng%B5877E96-7CB9-4108-941C-ACC1E84A3358%Тяжелые$Я достигну этой цели.%I\'ll achieve this aim.%rus_eng%BA8D9F7F-C53A-436E-9351-A8F0996D623D%Тяжелые$Эти условия подойдут нам.%This conditions will suit us.%rus_eng%C345820E-92B9-440A-8B9C-99C118973F2A%Тяжелые$Я склонен был думать так.%I tented to think so.%rus_eng%C8722676-AE0F-4D19-B457-E68DB95C207E%Тяжелые$Предлагать делать что то.%Suggest doing something.%rus_eng%C990E979-D434-4E1B-9274-58260A2B8E15%Тяжелые$Я достиг этого результата.%I reached this result.%rus_eng%CAE64EC9-5692-474B-A093-7C2FFA64EADE%Тяжелые$Мы с моим другом будем уделять английскому/здоровью больше свободного времени.%My friend and i will devote more free time to English/ health.%rus_eng%CCD38D49-F89D-4381-A206-63E38519D685%Тяжелые$Это будет длиться вечно?%Will it last forever?%rus_eng%D2BE4D66-55CB-48DF-B00D-5F00292E2460%Тяжелые$Мы обдумаем это.%We\'ll think it over.%rus_eng%D3B32771-E279-404A-84D2-61A55DCC55F3%Тяжелые$Мы будем благодарны тебе за это.%We\'ll be grateful to you for it.%rus_eng%D61CBF31-AA34-4133-84B3-0B32D043202D%Тяжелые$Он отрицал свою вину.%He denied his guilt.%rus_eng%D6B7E254-73AD-489C-A9D9-20834403C64A%Тяжелые$Студент отгадает правильный ответ?%Will the student guess the correct answer?%rus_eng%D7735B11-EA2F-43C2-A6E3-5A7C92020244%Тяжелые$Это изменило мое отношение к ней.%It changed my attitude to her.%rus_eng%E303B0B3-23E3-426F-9607-BD17FE46D05C%Тяжелые$Мы считали эту победу очень важной.%We considered this victory very important.%rus_eng%FA9242B2-7601-4855-BD97-DB67EDD113F8%Тяжелые$Я буду гордится вашими результатами.%I will be proud of your results.%rus_eng%FECCD1FF-4DC9-4A03-85D5-C9BFE0B0D6F9%Тяжелые"
    /*
    private static let dataSourceLikeString = "Грубый%Rude%rus_eng%08D3809B-225C-4701-9FFB-1A803F767773$Она не дружелюбная/толстая%She isn\'t friendly/fat%rus_eng%0A2D7684-14FD-4835-8899-A26113D5631D$Это ее страсть?%Is it her passion?%rus_eng%0A41B3B1-DFBA-4E22-B322-2B6AD2742C00$Это наш последний шанс.%It\'s our last chance. (чанс)%rus_eng%0E2DF674-AED6-4363-8935-93D05C2D105E$Этот звук очень громкий/ тихий%This sound is very loud / quiet%rus_eng%10603885-FD46-4D11-AE95-6B614A8FC9E2$Он музыкант.%He is musician.%rus_eng%11B46222-7571-43C4-AE45-A4EF6C3EF0F0$Он не больной.%He isn\'t ill.%rus_eng%15ABA42B-40BF-41BB-AA41-F1FCD1A275EF$Это мое окончательное решение.%It\'s my final decision.\n%rus_eng%15DAD147-025C-48C8-A45B-40FE2E966DD3$Я надеюсь ты помнишь это!%I hope you remember it.%rus_eng%17E31138-74A0-4FB6-882D-604BCC282BE7$Я прекрасно осознаю это.%I perfectly realize it.%rus_eng%18D4D3E8-520D-4C1F-BDE2-11E5F010A158$Они часто разговаривают про это?%Do they often talk about it?%rus_eng%1D6C539E-96F0-453F-BC1C-5C49F1AD7142$Это комфортно для меня.%It\'s comfortable for me.(если время то convenience)%rus_eng%24061375-4906-4585-9E7D-C28712E3BA9D$Аморальный - моральный%Immoral - moral%rus_eng%24A378B5-868E-469D-822B-3EDC8F4CDC44$Они живут раздельно.%They live separately.%rus_eng%2C0BEF10-FEC1-4968-AC3F-6E0C07DCA3E0$Она рада видеть его.%She is glad to see him.%rus_eng%2D4C4932-710B-4B62-9F2C-48F576371BAF$Я возможно это сделаю.%I may/might do it.%rus_eng%2E06FEFA-36E8-42CA-AFB1-6B04F5F34789$Его брат ведет себя странно?%Does his brother behave strangely?%rus_eng%328A7858-B751-453F-9EFE-ADFBFD5A3AEC$Как он готовиться к своим экзаменам?%How does he prepare for his exams?%rus_eng%3FF571E6-8547-4136-8E22-A9BD7EB90604$Он соревнуется с ними?%Does he compete with them?%rus_eng%43AB3211-D03A-4608-9C30-800EA6438951$Вы знаете друг друга.%You know each other.%rus_eng%4AF110E6-BB47-49AA-B3E8-12A1157863DD$Это на полу%It\'s on the floor%rus_eng%4C6E7150-40B3-463B-B9C9-1855006FAAC0$Я обожаю этот канал благодаря нашему учителю.%I am fond of this channel thanks to our teacher.%rus_eng%5AD35A58-BD6C-4740-8A65-D774CEAD9AE1$Что пугает тебя?%What frightens you?%rus_eng%5B77016E-0723-4D64-963B-87A353A6F098$Это интересует его.%It interests him.%rus_eng%5D1F3176-83E8-4526-AFA4-5B68A2D36178$Тебе надо закончить это к завтрешнему дню?%Do you need to finish it by tomorrow?%rus_eng%62031839-4CF6-49E7-BB91-91D5CE4F8CCF$ Мы рядом с этим местом?%Are we near this place? (Без артикля!!)%rus_eng%666825B1-F107-4B5C-AC16-E338A0162636$Забывать, помнить%Forget - remember%rus_eng%685B04CD-3FD0-447F-BF0C-1B6157C4C019$Женат - холост, разведен%Married - single, divorced%rus_eng%6D2B9FEA-F5BA-49F5-A7C0-57027822560A$Мне надо адаптироваться к этим условиям.%I need to adapt to these conditions.%rus_eng%6FB6C0DB-5786-4233-8207-A1AD49C35107$Доверять мне%Trust me%rus_eng%758E4C6A-8E0A-4732-9D9E-0E5FAC68CD54$Что он пытается делать чтобы изменить это?%What does he try to do to change it?%rus_eng%75CDD4B2-0A6A-4B20-BFDE-93B15FC87A4B$Это потеря времени / денег%It\'s a waste of time / money%rus_eng%7F114BB3-D729-4428-A045-2B5BEFCD2955$Покупать - продавать%Buy - sell%rus_eng%800BEB82-8425-47A3-AD33-580E20D00C93$Я прекрасно понимаю тебя.%I perfectly understand you.%rus_eng%801CFF2A-DF85-4323-B893-A86AD06D4FE6$Это естественно%It\'s natural%rus_eng%8397702A-F5D1-42CA-AA86-3F33BE2DA244$Простота%Simplicity%rus_eng%85B0DEED-3421-4EF9-8390-733F41ECBC01$Значение этой фразы не ясно для меня.%The meaning of this phrase is not clear for me.%rus_eng%85C4DBAC-3D96-461D-94F4-6ED5EB7E7658$Как ты обычно празднуешь свое день рождение?%How do you usually celebrate your birthday?%rus_eng%88E11A02-04B7-44FF-AD55-4FAC4DC0EF81$Его жена не ходит за покупками так часто.%His wife doesn\'t go shopping so often.%rus_eng%895C3542-0F3F-49E7-A68F-7C5F2ADA8DA0$Моя сестра не общается с ним.%My sister doesn\'t communicate with him.%rus_eng%8A4B0421-920F-45C8-B295-C633946F3111$Каким видео ты восхищаешься больше?%Which video do you admire more.%rus_eng%8B3611ED-69BE-4551-A3D4-15D431DD991F$Мне следует делать это.%I should do it.%rus_eng%8F94433B-8D49-4B08-B86B-37081A70DE03$Этот мальчик его старший/младший брат?%Is this boy his elder/younger brother?%rus_eng%91E3133E-34C1-4E73-8C3C-F8ACEDF65A4B$Я обожаю иностранные языки.%I enjoy foreign languages.%rus_eng%922C3E8C-6966-4219-880E-1367619F38F1$Мне не нравится эта мебель.%I don\'t like this furniture (фенече)%rus_eng%989CB1AE-7378-4C40-8D39-A3DB6C581A4A$Какие каналы популярные в наши дни?%What channels are popular nowadays?%rus_eng%9FA603A9-DD12-4169-9A37-6F85AA0F5DD0$Его поведение не обычное?%Is his behavior unusual?%rus_eng%A0206412-AC2F-4870-AAAB-A22D99BB725D$Вежливый/ невежливый%Polite/ impolite%rus_eng%A5AF40E0-6419-4F8F-9EB2-5060905E5069$Я люблю смотреть этот канал(как случай)%I like watching the channel.%rus_eng%A8A404DF-27A1-4573-A558-89F7129E342B$Все студенты знают значение этого слова?%Do all the students know the meaning of this word?%rus_eng%A98955C6-01FA-44C7-B202-654780643233$Мне не нравится эта реклама.%I don\'t like this advertisement.%rus_eng%B2C3934F-F7F1-409B-89BE-DA196798AE18$Это кресло/стул удобное для меня.%This armchair/chair is comfortable for me.%rus_eng%B4CCAE25-74E1-4410-9A3A-39FE6D04B9F6$Болезнь.%Illness.%rus_eng%B7FBACE7-673C-4FC9-BF32-6FDD2EBFFDC6$Твоя сестра одна сейчас?%Is your sister alone now?%rus_eng%BAC3E111-C16F-40E5-A95B-B81A819A12E1$Сумка дорогая?%Is the bag expensive?%rus_eng%BF2CEACC-2BEA-49E2-9B6D-BA6EA14AFF98$Еда вкусная/очень вкусная?%Is the food tasty/delicious?%rus_eng%C7D75F0A-6479-4244-99A8-EDDD913C522B$Я хотел бы общаться с людьми из других стран.%I\'d like to communicate with people from other(для множительного числа) countries.%rus_eng%CB643421-B832-4DFC-BF68-47A81D3EFB9D$Благодаря ясным обьяснениям.%Thanks to clear explanations.%rus_eng%CC08BEF8-EC60-4CCF-B559-C44B0C6E9E75$Презентация не ясная.%The presentation isn\'t clear.%rus_eng%CDAF9936-9EEB-4897-A5AD-D9393417B0D4$Моего опыта достаточно?%Is my experience enough?%rus_eng%D16FC07B-2FB8-4A82-A5D8-26853A0454B3$Наш учитель часто сравнивает наши результаты.%Our teacher often compares our results.%rus_eng%D3B337D6-83F1-4606-8678-455435C3BABA$Взрослый мальчик.%Adult(grown-up) boy%rus_eng%D62C89C4-4270-405C-8365-48FABC77E56F$Это необходимо.%It\'s necessary.%rus_eng%D62CD3D1-A223-4575-8916-D17CA655FAFE$Я интересуюсь этим.%I am interested in it.%rus_eng%D6806120-1398-4022-90E2-24BD39A14A2F$Низкий - высокий, высокий человек.%Low - high, a tall man.%rus_eng%DE86BBDC-77CF-4178-AD4F-81F23D17C760$Смеяться - плакать(кричать)%Laugh - cry%rus_eng%E15F8761-25DB-4A81-9787-6B3940E479AE$Толстый - худой / стройный%Fat - thin / slim%rus_eng%E2210DA5-6496-4FF2-ACE2-D6702447351C$Я получаю удвольствие от анг / спорта%I enjoy english / sport%rus_eng%E63F1C96-D1CA-48EC-A572-C31F07DDFE3E$Я обожаю смотреть этот канал.%I enjoy watching the channel.%rus_eng%E6C79266-A942-4161-8B46-0DE45FD2D575$Я увлекаюсь музыкой/чтением.%I am keen on music/reading.%rus_eng%EACC61B2-9FF0-40E2-8A31-C3401304F5F2$Это не удивительно.%It isn\'t surprising.%rus_eng%ED54DBC0-8235-4386-9196-1AACFA3B0B9E$Давать - брать%Give - take%rus_eng%ED7379A0-6A86-464B-A10E-3850E16D806F$Его партнер тратит слишком много денег?%Does his partner spend too much money?%rus_eng%EF0750FB-96FA-4B0F-A9FC-CC44FA59C807$Мне не нравится реклама.%I don\'t like advertising. (адветайзин)%rus_eng%EF105252-0B92-487C-AE92-78CBCBBB0AE2$Они часто смеются над этим/ над ним%They often laugh at it/ at him%rus_eng%F188C6C5-F66A-401E-89BC-30BCD6B61DFD$Сколько времени у тебя занимает добраться до дома?%How long does it take you to get home?%rus_eng%025C49F3-17B3-4836-8152-96D36E72582A$определить ограничения%Define Constraints%rus_eng%0336BC43-61F6-44D4-9DAD-A5BC4F2B1B5D$время от времени%From time to time%rus_eng%042F7145-DEFF-46C5-A74C-F6CA51D57E50$шпион%spy%rus_eng%07957275-3BA1-4305-B952-C2772908BA7B$Этот бизнес прибыльный?%Is this business profitable?%rus_eng%07D27202-7198-47E0-9273-F62D83A5844F$Ты очень добрый%You\'re very kind%rus_eng%088E4AA8-62BA-49E3-9750-C076C9526095$Мы полны энергии%We are full of energy%rus_eng%098656B2-8EC8-486F-BD48-3DC73DAD118C$Где ближайший супермаркет?%Where is the nearest supermarket?%rus_eng%0B125DB8-ABF4-425C-912D-15DD254A5C4E$Отказаться платить%Refuse to pay%rus_eng%0B693F01-A6A5-464B-A44A-A5C5F18233A4$Это необходимо.%It\'s necessary.%rus_eng%0C63EF01-0A0C-4497-B678-30D8C6CE731A$Он такой талантливый%He\'s so talented%rus_eng%0DAD1205-2A3B-46B6-95C2-8218D7146CD5$ненавидить эти вещи%Hate these things%rus_eng%0FD403A0-0CFC-44B6-8BD7-4B841F03B177$Жарко%It\'s hot%rus_eng%10B44B42-960A-45C0-9872-42430BA76F8C$взаимодействие с пользователем%User interaction%rus_eng%10F2A425-D0BA-469D-A562-6518626AF79A$пустышка, маникен%Dummy%rus_eng%12A88D94-EF63-40EF-AB98-1419C445EB43$Это с права%It\'s on the right%rus_eng%15002AA7-DECC-4A11-AD0D-661DC0F57B13$Что беспокоит тебя?%What worries you?%rus_eng%1848D19F-E738-447A-BECA-A55C89269268$Мы не уставшие%We aren\'t tired%rus_eng%1A880805-2FAE-4044-9C35-DFD7E8C67612$возможность%capability%rus_eng%1B74FA43-F149-4A87-9C96-045354B2BDC2$Наш учитель очень трудолюбивый%Our teacher is very hard-working%rus_eng%1C4E6913-4254-4BB3-B9DE-C0CDB355816F$Снова и снова%Again and again%rus_eng%1C666042-BFEC-4A08-A984-15E7EC988D85$Это дёшево%It\'s cheap%rus_eng%1D42A3CE-E252-45F0-9B3B-822E2C779D4D$Проводить время%Spend time%rus_eng%222C8123-78AA-45FA-A2AC-105387807784$Описание%Describing%rus_eng%27ABDBD9-8B0C-4ECE-A857-07AE21ED4934$Он такой умный%He\'s so clever (smart - больше смышленый)%rus_eng%27CE03D4-C7EF-42AA-8617-BBA44559489E$решить эту проблему%To solve this problem%rus_eng%29CB3293-28EB-4E5E-865E-FCD31DAFA859$Он такой талантливый человек%He\'s such a talented man%rus_eng%2A5C2940-884A-4E0F-8D7F-68D953722A55$Что твой босс обычно отвечает?%What does your boss usually answer?%rus_eng%2C339A6F-2F1A-4FBD-8E08-262DC84B7591$Мой бос очень занят сейчас%My boss is very busy now%rus_eng%2CF6EF29-5B7E-4CE9-BA30-62E16E927582$Совет%Advice%rus_eng%2F57CB89-9703-45E1-B5ED-E126768EC1B6$расписание уведомления%schedule notification%rus_eng%2FBED160-F70A-474D-98F5-886853BBFF2A$разрешение получено%permission granted%rus_eng%38046F3B-CAE2-4B83-85D0-EF4BD8F97A99$Он музыкант.%He is musician.%rus_eng%383C51FD-A4C3-4B48-8B65-9388BCB02DB8$Это на полу%It\'s on the floor%rus_eng%38DCDDD8-E6D0-42C5-B8F8-D3B6B9949D60$Она рада видеть его.%She is glad to see him.%rus_eng%38E3C35D-28FD-4ACD-AB10-03FDB32B23DD$Вся правда%All the truth%rus_eng%3920208D-1D72-4725-8669-C2BD9D59DA31$Это ее страсть?%Is it her passion?%rus_eng%3B071178-4ED3-4600-AB0A-E2EF76CBB674$Она ходит в школу с большим удовольствием%She goes to school with great pleasure%rus_eng%3B0CF10C-A3B2-48F7-A6A6-2D3D5EA7532E$Сколько это стоит?%How much does it cost?%rus_eng%3C400456-CD56-4DA4-B7EF-52508C122BA3$Почему ты против этого?%Why are you against it?%rus_eng%4140F969-6EC7-4225-B120-2B665A5EAAF9$Для удобства%For convenience%rus_eng%41519764-F685-4368-BB10-5EEF4FBAF01A$Я в правильном месте?%Am i in the right place?%rus_eng%4187B41E-5C99-485E-A9A5-1ECE83D42E12$Добираться на работу%Get to work%rus_eng%43D52568-B3D5-4517-83B5-152729C69253$Дождливо%It\'s rainy%rus_eng%468F98D2-55E4-4B94-BE76-13D36290D387$вложение%attachment%rus_eng%4C03395A-8A1C-4CFE-A0D4-E8B5427F8066$утверждать%Assert%rus_eng%4CDF23ED-51A7-4E73-813F-3498E9745CE6$следующие специальные символы%the following special characters%rus_eng%4E23C06A-7D95-4493-8AA3-E5768FF71D7E$Выполнить запрос (2 вар)%Execute/perform request%rus_eng%50655000-A0CC-4691-B5E2-2A31FE31A84A$прибыль%Profit.%rus_eng%514757E4-84B0-4184-BCF6-19E46AECBDC9$заглушка%stub%rus_eng%532C131E-E5B1-416E-BB73-1C2633678C58$Мы не разделяем твою точку зрения%We don\'t share your point of view%rus_eng%5621C3ED-4F7B-40C0-B5BC-7EBF9A0D81B9$Это очевидно%It\'s obvious%rus_eng%58E2324C-BECA-48B9-9705-80715A4571E6$Зависит от тебя%Depends on you%rus_eng%59584C58-6CEA-433E-AAF0-0A8B4126607C$Я удачливый?%Am i lucky?%rus_eng%59606D0A-0580-4A86-9665-3C963AB3A92D$Тоже думает так же%Also think so%rus_eng%5A890459-8FEC-4DE2-A848-7520B5193C87$Это мое Решение%It my Decision%rus_eng%5CE05A83-65E5-4D92-B842-2D6A615CA7A9$День ветряный%The day is windy%rus_eng%613B69BA-6C89-430D-A89C-03512E92770E$Слушать радио%Listen to the radio%rus_eng%6483D17D-3B4D-458C-8219-987505299518$Он часто слышит это?%Does he often hear it?%rus_eng%681DDB9B-A30A-4F1C-9F1A-7C1D4EB4678B$Какую музыку ты предпочитаешь?%What music do you prefer?%rus_eng%687C92A0-AC6A-467C-91AF-86722B049B5C$Тепло%It\'s warm%rus_eng%69ED852C-2441-4CAD-A4CC-61DD2DA96B7D$Отдыхать%Have a rest%rus_eng%6BCA26CB-0DE0-4E00-BF91-F227D4491E9B$Знание сила%Knowledge is power%rus_eng%6C3BDC4A-F2C0-4111-9866-C2CA9A21AE9F$реактивные привязки%Reactive Bindings%rus_eng%6C753EA9-5664-40CE-899A-D7F07F64ADF5$Это естественно%It\'s natural%rus_eng%6E77F834-E32B-4F96-8921-987A836C35BD$Статья на английском? (Так де значит артикль)%Is the article in English?%rus_eng%702C7C2F-8031-43EE-94F0-018559CE55F6$Мы в парке%We\'re in the park%rus_eng%71F5054D-140E-4E02-B0F5-CD4F27B4CE58$Обмен сообщениями в облаке%cloud messaging%rus_eng%748D6C0B-204B-41C1-97C8-EBA6B415DF35$Улучшить%Improve%rus_eng%7572CB88-A690-4209-A527-9D4CE4BD82A9$День ветряный%The day is windy%rus_eng%757AB1BA-677B-408F-8F84-235C268C20D4$Добираться до туда/сюда/домой%Get there/her/home%rus_eng%75B90AF4-48B4-4069-9B31-B58E3C20D30C$Они бедные%They\'re poor%rus_eng%7731AF93-E6C7-49B4-8440-75179ADEB7A1$Это не так%It\'s not so%rus_eng%7A461AF8-6D17-45FD-9897-A25A57027B03$Это комфортно для меня.%It\'s comfortable for me.%rus_eng%7F3EB4DC-90FD-49CD-912D-84740878FD41$Блестящий результат%Brilliant result%rus_eng%7FBF222A-ACF1-497A-BA6F-22DFCC55F90E$Какого рода книг ты читаешь?%What kind of books do you read?%rus_eng%85B50031-412D-4317-B624-2B2DF20DFAB5$Это возможно/ не возможно%It\'s possible/impossible%rus_eng%85F01EE4-CEE2-43F0-BCBA-FD56BE99ABBA$буфер обмена пустой%the clipboard  empty%rus_eng%86C09BA4-A031-4069-8BF7-70485134539F$Не успешный(одно слово)%Unsuccessful%rus_eng%88585D8E-9BDF-4877-8600-675EEDA71819$Как регулярно?%How regularly?%rus_eng%8A38173A-C258-401A-B540-66F8AD478A36$Значек%Badge%rus_eng%8ACB414C-7B1C-4567-A446-48916A91F470$привлекать%Attract%rus_eng%8BB741B5-8FE4-4973-BCD2-FFD6B7A152B0$Они часто смеются над этим/ над ним%They often laugh at it/ at him%rus_eng%8EA43FD2-3052-45D8-8430-F27520D20AE5$Сколько эти джинсы?%How much are these jeans?%rus_eng%91545B43-845C-4C51-B103-F38EA77D4E8C$Почему твой друг хочет искать новую работу?%Why does your friend want to look for a new job?%rus_eng%919265D3-C27D-49DC-8523-72C5C58CA34B$Темно%It\'s dark%rus_eng%91A7D12A-8B9C-415C-B0D2-DC06FE385D6F$Это потеря времени / денег%It\'s a waste of time / money%rus_eng%91D6BFD4-FB27-4FAD-A44C-DD2D89D639C4$Я холостой%I\'m single%rus_eng%92F2C8B3-4043-4FA1-BFB4-3BC61B25C612$Они боятся этого?%Are they afraid of it?%rus_eng%94AEFA2F-E444-48BC-8DD5-42EBAA610A73$получать%receive%rus_eng%99BD1605-2992-4193-8EC0-8529478DE499$Сколько стоит эта пара брюк?%How much is this pair of trousers?%rus_eng%9DB30862-DEDE-4455-A74C-89824B3F8542$Я не удовлетворен этим решение%I am not satisfied with this decision%rus_eng%A02143DA-B445-4F85-B1EB-1FF4F0CCA52B$Критиковать%Criticize%rus_eng%A057FA21-63D1-4A58-A89E-CBE1E5C684A3$Это ее мнение?%Is it her opinion?%rus_eng%A0AF6A7A-DA06-44F0-A19B-DDD5E495C4F2$взаимодействовать с различными потоками%interact with various streams%rus_eng%A1847E38-E83E-4A89-8336-BBAD881706E6$Это его собственная квартира?%Is it his own flat?%rus_eng%A1EA5A76-9C31-4479-A985-9140F3CD600E$явный эпл айди%explicit app id%rus_eng%A264BBD0-338A-4E1A-B86B-076CC9F84FFF$Что в твоем кармане?%What\'s in your pocket?%rus_eng%A27EF155-DD99-4D62-97AF-2CE532D89A14$Специальное предложение%Special offer%rus_eng%A2A04385-1D84-46D5-B6F7-F8CDAEA9BD49$Это кажется скучным?%Does it seem boring?%rus_eng%A2AB6EC3-3654-427F-BC20-83E7921156A4$потомок%Descendant%rus_eng%A34FC96C-FA82-41DA-AB1B-103591D54E8C$Те уроки не эффективные%Those lessons are ineffective%rus_eng%A44396AE-69BA-474C-9974-2ECD29F98DD8$рукопожатие%handshake%rus_eng%A44A1D92-5225-4CED-978A-22013B68670A$Он в здании?%Is he in the building?%rus_eng%A45A819D-5EF3-420B-AF6D-64F9F77C148B$Во сколько ты ложишься спать?%What time do you go to bed?%rus_eng%A4B4556C-E1F7-4C80-B8F0-D8DFBB5718D5$Я не женат%I\'m not married%rus_eng%A74C25FA-00AC-4F13-9098-64513FCCBCB4$Как часто ты занимаешься англ?%How often do you learn english?%rus_eng%A7D60F74-9BEA-4FC7-ADF1-EA46D17EFC97$Откладывать%Defer%rus_eng%AB141804-45D4-4A6D-B434-DCF6E8B983C1$Это хорошая манера%It\'s a good manner%rus_eng%AD1E5366-6E8C-41AD-82DC-B03738CA1260$Любовь прекрасное чувство%Love is a wonderful feeling%rus_eng%AF86A536-52B9-46DE-B6DE-76BBB8FB38F2$Это мое окончательное решение.%It\'s my final decision.%rus_eng%B0932F9D-C667-4F99-AE9C-73AF2B9BE4EE$Солнечно%It\'s sunny%rus_eng%B0976867-4FE8-4F21-A9F1-D2A9359A5FF2$Я обожаю иностранные языки.%I enjoy foreign languages.%rus_eng%B2A35311-E549-4D4C-8052-3B8C83CBB209$Решать%Solve.%rus_eng%B58DED38-C5F2-470B-81C9-DCF98523841E$Почему он жалуется так часто?%Why does he complain so often?%rus_eng%B99E15BF-060C-4708-9435-EDD072138EEA$Неудобный.%Inconvenient.%rus_eng%BAAB31C9-5B61-4DBD-A6F7-BC048ADD9F9A$Этот экзамен кажется очень сложным?%Does this exam seem very difficult?%rus_eng%BACA85F7-5ABB-478C-A17B-2F36E360B939$Держите ваш доступ до конца вашего текущего членства%Keep your access until the end of your current membership%rus_eng%BD68526B-282D-4BD8-AE95-5E8D80E301E6$Они ленивые%They\'re lazy%rus_eng%BFA1716D-10DA-4BC6-9C81-CBFC69970453$Обещать%Promise%rus_eng%BFB41E3C-0C74-4B91-9F5D-3E4377D6E680$Он в командировке%He\'s on a business trip%rus_eng%C656B423-2392-4ECD-9421-4E6808F7CBC9$Это не вдохновляет меня%It doesn\'t inspire me%rus_eng%C6B32BC9-D630-4D47-BCAA-238727F2707A$Я конечно%I  certainly%rus_eng%C89EFA42-BC90-4963-AA2D-D6AACEE7364B$Вовсе%At all.%rus_eng%C9B53D0E-D405-4FC0-B039-8FCBA35367F9$Ты не прав//%You aren\'t right/ you are wrong%rus_eng%CAFD30DC-3388-4273-855C-9021CD973C79$Это большой успех%It\'s a big success%rus_eng%CDEFBD05-9AD2-4F22-8511-375CB487A282$Это очень высокий/низкий уровень%It\'s a very high/low level%rus_eng%CEA5E63C-4166-4DBF-9472-8BBD13C16F9F$привязки модуля представления%bind view model%rus_eng%CFC1FE21-4942-493E-A3C9-F878CC51CE16$Я получаю удвольствие от анг / спорта%I enjoy english / sport%rus_eng%D259F99C-3AD7-49C5-B831-1A4A163C64EC$как можно скорее%As soon as possible -%rus_eng%D89DB3C7-D77C-42A9-9984-8437605ADDE3$Мы не в правильном месте?%Are we in the wrong place?%rus_eng%DF6C331B-648C-4065-A98A-84793B85DE87$Требования метода.%Method requirements.%rus_eng%DF9D826A-E0C0-404E-AC8F-CC3A89869B3C$Сколько стоят эти брюки?%How much are these trousers?%rus_eng%E09ACF22-93B1-465F-B4B8-02EE19D53B07$Обьяснять%Explain%rus_eng%E1FCA315-B43D-43EB-84EB-9DBB3A854F2C$макет%mock%rus_eng%E21FA769-B971-4475-8DED-364467107E8E$Заранее спасибо%Thanks in advance%rus_eng%E336F615-D23D-4112-A2DA-85B74FF80E5B$Способность%Ability%rus_eng%E3D69A14-65A1-4306-A957-E8D6448CEC2A$Я на работе%I\'m at work%rus_eng%E41B0DCE-1C12-4926-ADBB-BC7C5CB8228C$исправить эти ошибки%To correct these mistakes%rus_eng%E671F7FE-A0D4-4486-A75D-3C85143312CF$Она такая мудрая женщина%She\'s such a wise woman%rus_eng%E684BF04-7BDD-4645-87B7-FD8718A07C06$Мы не злые%We aren\'t angry%rus_eng%E7DA0F5C-7F81-4578-8AAF-2D6EC9A43A2E$Я дома%I\'m at home%rus_eng%EA9228B9-24A6-4304-966D-1AEE739F0451$Правило%Rule%rus_eng%EE4D700E-DC68-40F2-A2D8-4E40762EC2B8$Это лучше/хуже%It\'s better/worse%rus_eng%F0D58EA0-4E89-4D0F-B7D4-485ADF95202A$это может быть проблемой?%could that be the issue?%rus_eng%F3BF0CE5-E84B-4B47-A2EC-4B83A3EE333D$согласен%Agree.%rus_eng%F673E116-26A2-4C8A-8735-8CBB6D2A5458$Ты прав%You\'re rigth%rus_eng%F6F03618-C883-4DDF-8216-818A3FFCFE8E$Я уверен (2 варианта)%I am sure/ I am certain%rus_eng%F7545ECC-3F09-4356-9B4E-AF4B1AF292EA$Не соглашаться с тобой%Disagree with you%rus_eng%FCD7773F-B1FC-4F60-812A-1CE92B1D5139$Они не смогут разрешить этот конфликт.%They won\'t be able to resolve this conflict.%rus_eng%05158D66-3815-4651-9EE6-7C9EB48F0EE5$Я буду гордится вашими результатами.%I will be proud of your results.%rus_eng%05D1198B-2FD2-4C61-94E7-5EB1E3715DB7$Он скоро женится.%He will get married soon.%rus_eng%0A463A9E-8443-479E-B3D1-E24DBFA417EA$Это будет потенциальная угроза?%Will it be a potential threat?%rus_eng%0CA1CDF6-FA14-450F-85A3-09D6D4378ECE$Тебе повезет.%You\'ll be lucky.%rus_eng%0E2C3A3E-CDA5-4D1C-A722-191A51E10580$Это будет длиться вечно?%Will it last forever?%rus_eng%1024B154-9592-4349-B89D-FB29B00DFB5E$Мы не будем конкурировать с этой компанией.%We won\'t compete with this company.%rus_eng%114292B8-6EE1-4CB1-B233-12F8E46E5638$Это произойдет рано или поздно.%It\'ll happen sooner or later.%rus_eng%1173B230-EED2-4C46-9C98-C61FC1FD6596$Власти будут регулировать это как то.%The authorities will regulate it somehow.%rus_eng%12C22B40-2ADA-4EA3-A8F0-924DF197CB71$Это будет не законно.%It won’t be legal. (It’ll be illegal)%rus_eng%1374181E-6452-4A44-BAF2-43D915836824$Они скоро разведутся?%Will they get divorced soon?%rus_eng%139A788A-BFE4-406A-A114-37C1CA2EEE93$Мы минимизируем издержки.%We will minimize the costs.%rus_eng%139EC145-FE0F-4F65-9FFB-3A19C2602112$Этот результат впечатлит их?%Will this result impress them?%rus_eng%148DDAEA-7AD7-4A59-AABA-DDE2C0A73DBD$Мы с моим другом будем уделять английскому/здоровью больше свободного времени.%My friend and i will devote more free time to English/ health.%rus_eng%152189C0-C5A9-45CD-A7A0-279D58D95931$Я заработаю 500 долларов.%I\'ll earn 500 dollars.%rus_eng%1B104815-B7CC-4A9C-B882-86DBFFC417ED$Мы с другом поторопимся.%My friend and i will hurry up.%rus_eng%1DB63042-2284-4427-BF8B-A51D6AF7B654$Как ты сумеешь решить эту проблему?%How will you manage to solve this problem?%rus_eng%1E7B4D80-43B6-4D2C-AF2E-91C363970A33$Этих знаний будет больше чем достаточно.%This knowledge will be more than enough.%rus_eng%1EA0DDA2-8031-4F3A-B69D-F5D807BBEDA2$Сколько денег ты потратишь на это?%How much money you will spend on it?%rus_eng%1EC30377-D8DD-44E5-B571-CE2BB4478810$Я постараюсь не делать это.%I\'ll try not to do it.%rus_eng%2178813A-A732-4373-B912-E26395C7212F$Послезавтра%The day after tomorrow%rus_eng%217D896D-9573-4766-A06A-B684A50E5B22$Я думаю он будет обожать спорт, но это не обязательно означает, что он станет профессиональным спортсменом.%I think he\'ll fond of sport but it doesn\'t necessarily mean that he\'ll became a professional sportsman.%rus_eng%2322A631-B555-4715-8B19-46FA4419CF04$Что будет принадлежать ему?%What will belong to him.%rus_eng%2323406E-C3A0-439E-B5F7-65F15B93AB39$Когда она присоединится к нам?%When will she join us.%rus_eng%25DF48C9-66BE-4C1E-A5B2-76CEEE8CBF44$Ты будешь скучать по ней?%Will you miss her?%rus_eng%2760D6B2-0BEF-483D-98F8-1D1F65DC9BEC$Жизнь накажет его.%Life will punish him.%rus_eng%27BD8A41-4761-4022-8C46-205907C4462B$Он отправит ему такое важное письмо.%He\'ll send him such an important letter.%rus_eng%27CD3116-CF8E-4B89-85D5-2F08CB8B45D8$Этот канал поможет вам выучить английский бесплатно.%This channel will help you learn English for free.%rus_eng%296FB87F-DDD9-45DC-9DE7-E815A8D7DC11$Мои коллеги не поддержат эту инициативу.%My colleges won\'t support this initiative.%rus_eng%2EECACD9-6CF1-40C4-B7C6-B0304E20212D$Ты не сдашь этот экзамен без подготовки.%You won\'t pass the exam without preparation.%rus_eng%32D6345E-0E71-421D-9E8C-941C4A93B878$Мальчик не выучит это за один день.%The boy won\'t learn it in one day.%rus_eng%3300B39E-4304-4716-ADE2-089B417FA316$Ты пропустишь этот автобус?%Will you miss this bus?%rus_eng%3317EC8C-12FD-4575-B99E-2E43B1A833C8$Сколько времени ты потратишь на это?%How much time will you spend on it?%rus_eng%36C5E4A4-D08E-46EC-88CF-6EB345FFCCA0$Они будут есть свежие овощи и фрукты.%They will eat fresh fruit and vegetables.%rus_eng%3F32EC10-DD74-4C43-A738-2CACCCF4FD6E$Они будут вести себя более осторожнее.%They\'ll behave more carefully.%rus_eng%46CA4205-369E-41CE-A1BF-95F5EBB7FBA4$Она последует твоему совету.%She\'ll follow your advice.%rus_eng%48AD580C-7D78-4953-958C-8563B43D7ACD$Принимать серьезные меры.%Take serious measures.%rus_eng%49694A14-93FC-4BAF-820A-CD1C5C792925$Необходимо будет подписать отчет?%Will it be necessary to sign the report?%rus_eng%4AE6D3B1-4271-43FE-A810-9DDB7DC8790A$Мой босс не будет настраиваться на это.%My boss won\'t insist on it.%rus_eng%4B2E2841-6029-4FA4-9F4C-E5534B378D2E$Привести к успеху.%Lead to success.%rus_eng%4B8BD67B-14F9-4051-8108-B8D9C34728B6$Как они смогут решить проблему?%How will they be able to solve this problem?%rus_eng%4E6D5276-97A6-4B3C-A1B1-55E1496E03C9$Я не буду перебивать его.%I won\'t interrupt him.%rus_eng%50223862-0872-4CC7-A946-E43B3C91CE51$Она сохранит этот секрет.%She will keep this secret.%rus_eng%50EA469E-0B83-4FAF-AFF4-039224BC2604$Я смогу улучшить свой английский очень сильно(значительно).%I will be able to improve my english greatly(significantly, considerably)%rus_eng%5173DDAF-FE3D-4DE4-B372-DEDB7ECD2EE0$Жизнь преподаст ему рок.%Life will teach him a lesson.%rus_eng%53142401-02F9-43D5-8E68-D8D773812559$Наш менеджер по продажам посчитает это.%Our sale manager will calculate it.%rus_eng%5537B0DA-7259-43D9-9944-2960D2BF8A81$Все выразят неудовлетворенность текущей ситуацией?%Will everyone express their dissatisfaction of the current situation?%rus_eng%55AA4724-0D20-4A2B-A230-0768FC1F9420$Это не приведет к успеху.%It won\'t lead to success.%rus_eng%564B2FB6-F34F-4BB0-A59D-CBF93B9FEBDA$Я сумею удвоить наши продажи, не смотря на кризис.%I\'ll manage to double our sales, despite (in spite of) the crisis.%rus_eng%5BAFDBDA-2631-48D9-AF74-90B2C90EFBCA$Он не будет курить больше.(дольше)%He won’t smoke anymore.(any longer)%rus_eng%5BC55212-5901-481C-846A-B75F01E8F18A$Эти условия подойдут нам.%This conditions will suit us.%rus_eng%5DD60F7B-F4D2-4168-B9C6-480861A9C8B3$Этот подход не будет достаточно инновационным.%This approach won\'t be innovative enough.%rus_eng%5FE5C8CA-EBB4-4A70-906C-2055822B6C5C$Мы сэкономим деньги.%We\'ll save money.%rus_eng%673C8044-6FFC-4785-A719-F7EF930E51EA$Его нет дома.%He is out.%rus_eng%6A68EB26-00A7-4056-B8B7-D195704ED729$Настаивать на этом.%Insist on it.%rus_eng%6A938E43-F71E-47E8-AF37-3C010D8B75D7$Это не принесет тебе больше денег.%It won\'t bring you more money.%rus_eng%6CACB604-4F41-4A12-9EE7-3E435129EF6D$У них будет выбор.%They will have a choice.%rus_eng%701B2E5F-67EE-4DD3-A4AF-1148D30E1C25$Мы будем благодарны тебе за это.%We\'ll be grateful to you for it.%rus_eng%71226506-36F1-4E37-806D-CDA02DE390B4$Мог - сможешь - смогу в будущ.%Could - can - will be able.%rus_eng%73740CAC-4D61-46D1-8422-7C1795A44E2D$Мы не будем жаловаться об этом.%We won\'t complain about it.%rus_eng%7E5BE521-99BF-4C22-97F1-E3C883DD2EFE$Стемнеет скоро?%Will it get dark soon?%rus_eng%7EB942B3-597E-4FB5-B54F-9ADFB32E7FDC$Я достигну этой цели.%I\'ll achieve this aim.%rus_eng%847C2662-EE4C-4D77-9E1E-CF09E9CF25D2$Как долго твои родители будут отсутствовать?%How long will your parents be away?%rus_eng%85D33245-19DE-4421-8216-984EE387C02C$Все будут расстроенные.%Everyone will be disappointed%rus_eng%875DE131-A3EE-4A12-97DF-67B2741FF9A6$Он отсутствует.%He is away.%rus_eng%8A0ABEC9-FF00-4CDE-95CF-69A6ADB37C82$Мое произношение будет намного лучше?%Will my pronunciation be much better?%rus_eng%8B219539-9132-4734-B2EA-9D24CF378C19$Девочка завалит этот экзамен?%Will the girl fail this exam?%rus_eng%8FE98784-5AE4-4281-B7BC-1C0B2BF38549$Его бизнес партнер пожалеет об этом.%His business partner will regret it.%rus_eng%9009C8DE-4A56-432C-B2C3-1CCB0502685E$Люди часто путают эти слова.%People often confuse/(mix up) these words.%rus_eng%90F6FF3E-DB5A-4142-A10A-EEFF215D99E0$Учитель простит им.%The teacher will forgive him.%rus_eng%91660C05-207F-4338-86B5-940FB31B79A5$Ты укажешь на мои ошибки?%Will you point at my mistakes?%rus_eng%92DE7C22-0501-4B1C-B283-90CF874CDBCD$Большой / огромный успех.%Big /(huge, tremendous) success.%rus_eng%96A1C59F-BBB1-4E6E-BDC0-5AF16393C118$Мы обдумаем это.%We\'ll think it over.%rus_eng%9B456900-A0B1-4268-8935-7918B1F4FF01$В чем причина этого?%What is the reason for it?%rus_eng%A14C3EAA-0564-415D-AE21-8FBF09FA5CE2$Какие каналы твои друзья будут смотреть на регулярной основе?%Which channels will your friends watch on a regular basis?%rus_eng%A3DD23AD-2C5B-4D8B-BB6B-309FB16D5C9F$Все выразят свою точку зрения?%Will everyone express their point of view?%rus_eng%A5623B1C-5DD8-4503-AE49-E4614DC62E4C$Ты не повлияешь на него.%You won\'t influence him.%rus_eng%AB825002-9D79-4186-BCBC-7AFE476D9011$Директор упомянет это позже?%Will the director mention it later.%rus_eng%B109397C-091A-406A-909B-7A150719E07B$Дешево%Cheaply%rus_eng%B46248F1-8AF1-4CC5-B1E6-517D611EE331$Это будет стандартная процедура?%Will it be a standard procedure?(просиджи)%rus_eng%B4BA3DFD-A372-47D9-8CF7-FB0DDE60F3CA$Он починит это.%He\'ll repair it.%rus_eng%B5C29099-F6C8-4488-BF59-8657BC0AD951$Этот мальчик сдаст наконец экзамен?%Will this boy pass the exam at last?%rus_eng%B6DECDA5-8B16-442C-8272-F4242ACAD2DB$Она не будет отрицать этот факт.%She won’t deny this fact.%rus_eng%BD4D5DD4-BA48-464F-994F-08EC5CDD5BC0$Это будет нашим достижением.%It\'ll be our achievement.%rus_eng%BD632D82-4D56-4107-89F7-692B09E2363B$Они не найдут решение этой проблеме.%They won\'t find a solution to this problem.%rus_eng%C09D8CAD-EBA0-4489-B1B6-F8AF09A0A898$Мне кажется день не будет дождливым.%It seems to me the day won\'t be rainy.%rus_eng%C7BD8957-11AD-494E-A55B-14F812FEDA7E$Необходимо будет проверить это более тщательно.%It\'ll be necessary to check it more thoroughly.%rus_eng%C800E327-894B-402C-8E95-988BC0378924$Это поменяет мое отношение к этой проблеме?%Will it change my attitude to/towards this problem?%rus_eng%CBFE0340-5853-48B8-B3C6-A6B57C966EB0$Где будет проходить конференция?%Where will the conference take place?%rus_eng%CC54D97F-AF12-41A4-9235-B38C14C7B7FE$Неудобный.%Inconvenient.%rus_eng%CD5E4EC3-5C83-4345-9687-C7F3F32D5FDB$Это будет длиться около двух часов?%Will it last for about two hours?%rus_eng%CD877BAB-1240-481D-9C5D-14EE6C1C757E$Я сумею сделать что то. Я сумею сделать это.%I\'ll manage to do something. I\'ll manage to do it.%rus_eng%CF9F4F52-C3C1-424B-BFF7-C915F6C2D73B$Студенты посмотрят это в словаре?%Will the students look it up in a dictionary?%rus_eng%D14D838A-E54B-40B9-B386-C24F7159E659$Эти меры будут стимулировать наши продажи.%These measures will stimulate our sales.%rus_eng%D490FBC0-AF1F-4E64-B42A-B769F7721CE2$Я постараюсь не упоминать это.%I\'ll try not to mention it.%rus_eng%DB905370-EE20-448B-B0A6-7C913C26FC6A$Мой бизнес партнер отдолжит ему эту сумму денег.%My business partner will lend him this sum of money.%rus_eng%DD267F78-842B-4DFE-92AF-C48C694AD543$Это будет длиться больше двух часов?%Will it last for more than two hours?%rus_eng%DE4AC336-2988-4380-9105-5D4141B37B0D$Сколько денег ее муж будет должен им?%How much money will her husband owe them?%rus_eng%DEB89C83-1A6E-4243-855F-35C7E82567C9$Он жениться на ней.%He will marry her.%rus_eng%E04A6579-D649-480F-9E94-11E66C041516$Я думаю нам не нужно изобретать заново колесо.%I think we don\'t need to reinvent the wheel.%rus_eng%E09677D2-2B07-4073-A4D6-592C70F1B4A5$И так далее.%And so on. (etc. - et cetera)%rus_eng%E548C85E-A854-4A27-8DE4-3050CFDC0007$Ты будешь доступен завтрашним утром?%Will you be available tomorrow morning?%rus_eng%E611897A-078D-44AA-BED4-AD0B7DD69BCB$Студент отгадает правильный ответ?%Will the student guess the correct answer?%rus_eng%E825EE60-B419-4D6A-9061-5AC135716DEA$Я не буду принимать участия в этом соревновании.%I won\'t take part in this competition. (participate)%rus_eng%E855D204-EA23-4F76-B859-7150A183DE93$Гости не заметят наше отсутствие.%The guests won\'t notice our absence.%rus_eng%E8674191-EFDD-45D7-9F0F-5B7B4A31116F$Она не будет реагировать на это.%She won’t react to it.%rus_eng%EC360408-EA0B-4D31-9011-2E4562310B37$Ты будешь интересоваться этим?%Will you be interested in it?%rus_eng%EFBD1D0D-B82B-449D-8CDB-AFDB188784A9$Они смогут найти это везде.%They\'ll be able to find it everywhere.%rus_eng%F4E0A094-F53B-4678-93DB-3E7E88D2EAD8$Это удивит тебя очень сильно.%It\'ll surprise you greatly.%rus_eng%F520F7BC-9DB3-461C-A537-7AFFEA055226$Его друг займет эти деньги.%His friend will borrow this money.%rus_eng%FC5FFF35-A1A2-458B-9C8B-A1AE7F6E346A$Ты устанешь. (Ты станешь уставшим)%You will get tired.%rus_eng%FF5AA295-97ED-4A5B-813F-0D6985DC5A53$Кататься%Ride rode ridden%rus_eng%05045C90-11BE-4E26-A660-7A05A1AFD70B$Он украл ювелир украш.%He stole jewelry.%rus_eng%0613F420-44BE-43F0-8ACE-3058B80A7E8F$Он поставил стакан воды на стол.%He set a glass of water on the table.%rus_eng%061D890C-412A-4E9C-95EE-670DD9159673$Он сделал мне одолжение.%He did me a favor.%rus_eng%0931E1A6-52CC-4F08-B976-25828846E0A1$Мы выиграли в том соревновании.%We won in that competition.%rus_eng%098DE162-EBD9-483C-8335-4EBAB48D8FB5$Я услышал это в новостях.%I heard it in the news.%rus_eng%09E001EF-13F2-4D9D-949D-A5AF4022BEB9$Он написал такую интересную книгу.%He wrote such an interesting book.%rus_eng%0E297A34-50A3-479B-95F1-EBF01ADE070D$Я сел на стул.%I sat on a chair.%rus_eng%0EB4DC21-FEAC-4720-96E4-7AD79C552122$Я присел.%I sat down.%rus_eng%0F5418DB-5D78-400B-AA10-12DC74B01D81$Я поспал 10 часов.%I slept for 10 hours.%rus_eng%0FF444DF-591D-4E24-8A0C-302F652F4F7C$Летать%Fly flew flown%rus_eng%11B149B6-500A-44A4-B975-3532D913D64E$Этот солдат сражался очень отважно.%This solder fought  very courageous.%rus_eng%12EAA305-BA09-4F56-84E2-AD46D481972D$Понимать%understand - understood - understood%rus_eng%14B1E369-5189-4151-BFF7-B6F231AAEB3B$Он бросил курить.%He gave up smoking.%rus_eng%150B185F-2408-4C2A-8D8D-69786C1A0117$Чувствовать%Feel - felt - felt%rus_eng%1615112B-3113-47D9-8A0F-E5F1938A6CFA$Я поставил это на стол%I laid it on the table.%rus_eng%169ACE76-F2CE-413B-BADA-EEE2C08804D7$Я носил ремень%I wore a belt%rus_eng%17028C5D-6CB1-4E8F-BCAE-2456A253ADC3$Бежать.%Run - ran - run.%rus_eng%17469860-FFE8-4D4C-A2C3-52872E6D9021$Резать%Cut - cut - cut%rus_eng%18128E8B-6EA9-44F3-AC51-F075C721FD68$Продовать%Sell sold sold%rus_eng%18516A92-D54A-404B-AAB9-9EC38A0C58D3$Он выпил стакан вина.%He drank a glass of wine.%rus_eng%1DAECF39-F328-47E6-9230-B4EFD9AB94DF$Ловить%Catch - caught caught%rus_eng%1DB0DE9B-8DEF-473C-B588-AE6A165AD08A$Он пошел на работу.%He went to work.%rus_eng%1E245997-7CB0-4171-8590-1D64B81138F8$Быть%Be, was - he, she, it, were%rus_eng%1F21F156-CBA7-45A8-84FC-D36DB7502468$Сказать кому то%Tell - told - told%rus_eng%1F31D0C4-5C98-42B3-81F5-B74AB65081F8$Позволять.%Let - let - let.%rus_eng%1FD5D684-5DBC-4410-80CD-D3535B773456$Ставить%Put - put - put%rus_eng%23F5AC62-AF3D-48A2-8AFE-016A8DD90AD3$Он намеревался помочь мне.%He meant to help me.%rus_eng%2557F2F7-5D95-4B2F-98C4-DC6E37C74105$Писать.%Write - wrote - written.%rus_eng%2892E3C2-C885-4FAE-8EBA-27D73D7E69E4$Ушибить(ушибся)%Hurt hurt hurt%rus_eng%2A1A8FC4-B667-4808-9F28-D3105E0DF007$Я записал это слово.%I wrote this word down. I wrote down this word.%rus_eng%2AD88954-B693-4BA9-B770-C8DAA3ED053E$Рисовать%Draw drew drawn%rus_eng%2C89AF40-9A89-4C7A-87AF-60D54FEA347F$Поставил, установил%Set set set%rus_eng%2CC652F4-BA28-48A9-9010-82E88896F838$Платить%Pay paid paid%rus_eng%2EF09163-83C5-41F0-8881-047EF5AA42D7$Я вырос в маленьком городке.%I grew up in a small town.%rus_eng%2F09979B-105F-402F-AADC-2DA8589CE98B$Он вырыл яму%He dug a hole%rus_eng%309C4192-2F2E-46AA-8CD5-E721976B914C$Он побежала очень быстро.%She ran very fast.%rus_eng%325A5554-0CE9-438F-939D-BCCBB4BDB9C4$Я плавал в озере.%I swam in the lake.%rus_eng%3263D016-C833-4163-AEF4-99D258B8636E$Ушибить, задеть%Hurt hurt hurt (injured правильная форма)%rus_eng%3435BE74-CCB5-44D6-98E6-00DA38B12514$Он убежал.%He ran away.%rus_eng%3456C5B6-3E6B-4C71-8555-958CC32C7BE7$Думать%Think - though- though%rus_eng%360E857C-A244-4159-9A13-DFE5DDBC2508$Мы ловили рыбу%We caught  fish%rus_eng%37DCD079-950A-4B7D-BF9E-59EC55CBCA80$Держать(руками например)%Hold held held%rus_eng%39918636-70F8-4FA6-A930-1FD55A08F610$Я услышал это по радио.%I heard it on the radio.%rus_eng%39D214E9-35D1-48BA-84FD-E01311A15810$Он сказал мне все.%He told me everything.%rus_eng%39D65AA6-31E3-4C3D-BC62-0BD287D18748$Значит.%Mean - meant - meant.%rus_eng%3B7078E2-574C-4301-B267-AD201AD8E5B9$Встречать%Meet - met - met%rus_eng%40314E5A-14C1-47B1-B50A-9830D90368F8$Его машина сломалась.%His car broke down.%rus_eng%428BC027-E5D3-4E31-8D07-071325E45346$Идти%Go - went - gone%rus_eng%4386F8CB-5FAC-41A4-BA4D-3C1436FFF470$Он показал блестящие результаты.%He showed brilliant results.%rus_eng%452226BE-4DF8-49C1-B542-04F08EBB8FBB$Я потратил 700 дол на это.%I spent 700 dol on it.%rus_eng%48BB3EE9-F921-42E9-8736-BFAA539F40EA$Хранить%Keep kept kept%rus_eng%48D8FCE3-7EBA-40F4-A831-571B251518EA$Он порезал мясо на 4 части(кусочка)%He cut the meat into for parts. (pieces)%rus_eng%491EA9DE-765C-4939-B035-68042FD1E467$Он спрятался за тем зданием.%He hid behind that building.%rus_eng%4C09C361-03A7-47A5-94B6-F232F44593E1$Лгать%Lie lied lied%rus_eng%4CDA6A1B-0267-40C1-932F-71C290076DFD$Покидать.%Leave - left - left.%rus_eng%4D17A8B8-7606-4352-8B19-6E6BFE90C0F6$Это значило следущее.%It meant the following.%rus_eng%4D5DAD50-9F2C-4D61-932A-1A65E7CDD79D$Она покормила своего малыша.%She fed her baby.%rus_eng%4F8F58FD-5EC6-4F73-9740-739C75485435$Он нарисовал шедевр%He drew a masterpiece%rus_eng%50FCC1E6-B4C8-40C6-99A8-E502BCF8DC91$Я одолжил ему эту сумму дененг.%I lent him this sum of many.%rus_eng%5197152E-5FFF-4C3B-9F15-5EC7EB3382B0$Я встал.%I stood up.%rus_eng%52403871-B6D2-4D27-A85C-E5720D2986EE$Намереваться что то делать.%Mean to do something.%rus_eng%52BE19CF-5EDD-4091-BF65-1FFDAC5A77A5$Я обычно спал около 8 часов.%I usually slept for about 8 hours.%rus_eng%554196AC-ADA3-486C-B986-2BBC2B0DE653$Я ел это на завтрак.%I ate it for breakfast.%rus_eng%575FBD0C-6D33-4852-9737-31188C046EB5$Они ударили его очень сильно.%They hit him very hard / badly.%rus_eng%5951E42E-874F-4237-B321-1116791A05FE$Ветер вдруг подул.%The wind blew suddenly.%rus_eng%59B322ED-573E-41EB-B07A-637449A1E1C5$Купить%Buy bought bought%rus_eng%5A4F5F35-2911-4CF6-B50C-541EF045224E$Я заплатил за эту услугу%I paid for this service%rus_eng%5E4A3448-C7FD-4F8D-A961-6453170119EC$Она мечтала о карьере в музыке.%She dreamt about a career in music.%rus_eng%5F1D14F0-DD5E-4015-ACB0-E5874A98DA0A$Я понял тебя сразу.%I understood you immediately / at once.%rus_eng%615325E1-2E22-485C-944C-991FEE338E5B$Я прилег%I lay down%rus_eng%62CBD43C-466F-4EF9-9308-222E6D8D692C$Отправлять%Send sent sent%rus_eng%6443F9D3-932A-4607-A5F3-DA37BECD0472$Я полетел в америку%I flew to america%rus_eng%669FA18B-F189-4CB3-9BA5-7542C5548C07$Сказать -%Say - said - said%rus_eng%6A4A7B08-FC95-4EE2-87C5-9E6DB9E835EB$Услышать.%Hear - heard - heard.%rus_eng%6ACF7D80-F7D0-437A-993D-73F00A6A12E1$Они сражались очень смело%They fought very bravely%rus_eng%6EA9CD8F-AB56-4635-8E46-27B8930C95CD$Учить%Learn learnt learnt Learned learned%rus_eng%6FEBF184-D600-4D7A-A5FD-FFDCF352AF48$Они разбили окно.%They broke the window.%rus_eng%716230C3-6203-45B0-B1A6-97535C5EF437$Мы знали это в начале.%We knew it in the beginning.%rus_eng%77CD9356-6571-49BB-874F-7559520B67BC$Ударить%Hit hit hit%rus_eng%79EC3BC5-26C3-49F9-99B8-1A2D75F1B2EA$Могу%Can - could%rus_eng%7AF5AEEA-5EC5-401A-8C6B-9795689450BB$Поставить%Lay laid laid(set, put)%rus_eng%7B0D8F49-8031-4679-AB99-E276CEF67B80$Я записал это.%I wrote it down.%rus_eng%7BD9E6B7-65C3-4603-B35D-C9A2B89A7F7E$Прятаться%Hide hid hidden%rus_eng%7C643112-566E-4C9B-8E0E-606C1D5BC36B$Получать%Get - got - got%rus_eng%7FA42C2E-28E0-4A75-B3AF-891BF91321AD$Он сдержал свое слово.%He kept his word.%rus_eng%80121E65-AD1B-4F76-9F4E-6B82F49F2D9A$Я поеподовал англ%I taught English%rus_eng%81631459-14DA-41BB-978D-8F1DD9998AC1$Я плавал в бассейне.%I swam in the swimming pool.%rus_eng%81C95C0B-57EF-48F4-9635-F1C5454EB9B0$Он упал на землю и ушиб свою руку.%He fell on a ground (He fell down) and hurt his arm.%rus_eng%83CBA743-80F1-4427-B204-A588AD4C1B10$Становиться%Become - became - become%rus_eng%84B64569-FA26-4224-94B0-5D7395A788BD$Находить%Find - found - found%rus_eng%85D2879F-C4AC-4155-A539-5B11194B3709$Она чувствовала себя расстроеной.%She felt upset.%rus_eng%86887957-B72C-4EA4-9A2F-7897EED5CD98$Я сел в кресло.%I sat in a armchair.%rus_eng%87298F6F-69A8-4CBC-B385-7F4FFC038EC8$Пить%Drink drank drunk%rus_eng%881B3424-429D-4514-BADC-B70C9EC62C02$Он задел ее чувства.%He hurt her feelings.%rus_eng%88E267EC-D387-4936-BC5C-589DFA3C6F12$Преодолевать%Overcome - overcame - overcome%rus_eng%8A04C244-3F83-4054-BCB4-1728C35BE737$Он сделал открытие.%He made a discovery.%rus_eng%8AD58E65-EC00-4D0E-B6E3-6416CBF21606$Сидеть%Sit - sat - sat%rus_eng%8E3349B6-A91D-4A3E-AB71-19F9125638DD$Он мог обьяснять очень сложные слова используя простые слова.%He could explain very difficult words using simple words.%rus_eng%8E4FDDCA-FE6C-449C-818B-1B6C2FFF0B6B$Я был горько разочарован.%I was bitterly disappointed.%rus_eng%8E73251A-24B8-4990-B60E-1728BA777E2E$Знать%Know- knew - known%rus_eng%8ECFA2D6-22C4-4307-80E4-AA0A5CEC90AA$Прощать%Forgive forgave forgiven%rus_eng%8EDEF047-D5BB-43C6-9C43-BB3072781BF9$Капать%Dig dug dug%rus_eng%8FF936B3-23FA-41CD-9D90-AF7CD92D2458$Я поехал в Россию.%I left for Russia.%rus_eng%9239003D-1714-4381-BC8C-6F7CE5C8D820$Показывать.%Show - showed - shown.%rus_eng%924A73AB-90A7-490A-9662-0A86FEF84392$Я выучил текст наизусть.%I learnt text by heart.%rus_eng%931A37FE-3F33-482F-8721-9D8219038C8F$Сделал%Make - made - made%rus_eng%95B09259-FDD4-4AD1-B274-AC6C0F14A7C7$Расти, выращивать%Grow grew grown%rus_eng%9643B88B-5B76-42EC-B111-F3EFA3577C63$Они продали свой загородный дом за 50 дол.%They sold their country house for 50 dollars%rus_eng%96C701A7-7EF5-4D3A-914A-E29981335BDC$Я услышал это в первые.%I heard it for the first time.%rus_eng%9715D42A-E61F-40F4-A71F-8E0333E440DC$Он украл ее сумку.%He stole her bag.%rus_eng%974F439B-8A31-4CB9-8489-FE1DF10DC33D$Она простила все%She forgave everything%rus_eng%9A39D6EB-F164-42B6-9E6A-0055E0C24F1D$Тратить%Spend spent spent%rus_eng%9B5C9B79-8921-46D1-BE9A-CB48B4D9CBCD$Петь%Sing sang sung%rus_eng%9B9D60E8-ACDB-486D-B528-ABB2103C4B6B$Давать%Give - gave - given%rus_eng%9E77788C-574A-4ABC-A0E6-E3AADEB4B83F$Падать%Fall fell fallen%rus_eng%9E81410F-9541-4EBD-ADEC-1BA837C930C7$Я забыл позвонить ей.%I forgot to call her.%rus_eng%A1EEB259-D49E-4A13-A6FC-4C452EF63F1C$Подходить%Fit fit fit%rus_eng%A27B4AB2-9457-471D-8456-904AF8F8C326$Приносить.%Bring - brought- brought.%rus_eng%A343EB31-8D50-43FB-B58C-D1482D6F9D92$Я имел дело с поставщиками%I dealt with suppliers%rus_eng%A53AE305-0F97-47FA-BCE1-3314511A4F62$Я встретил моего одноклассника вчера.%I met my classmate yesterday.%rus_eng%A62F2D65-198F-4804-BFDB-82C9E743DE59$Они встретились на конец%They met at last.%rus_eng%A6312F62-6B34-4D64-A559-7208EF346057$Я полетел назад в зп%I flew back to ZP%rus_eng%A6781D3A-1E24-4A3F-A4BD-205A2D17C567$Мечтать%Dream - dreamt - dreamt(может быть правильным dreamed)%rus_eng%A7C9BEBE-83D8-436D-9909-FBF59B56398E$Я забыл эту вещь полностью.%I forgot this thing completely.%rus_eng%A8136B3D-5354-41A3-9324-AFE0A5B47588$Я заплатил за нее%I paid for her.%rus_eng%A82567BF-E268-4188-B3CB-3EBB0C81850A$Она выращивала фрукт и овлщи в своем собственном саду.%She grew fruit and vegetables in her own garden.%rus_eng%A8327468-308B-45CA-8051-A30E9ACDC943$Драться%Fight fought fought%rus_eng%A8B2B878-6A42-4996-B23E-2D01F4DB1694$Я плавал в пруду.%I swam in the pond.%rus_eng%A95BE85E-DB8F-4727-A727-4521AAE1D934$Он ударил по мячу.%He hit the ball.%rus_eng%A96B29BF-103F-49FB-8AA6-8C375D709830$Есть%Eat ate eaten%rus_eng%ABE7494B-D149-43D5-952B-88ED03E5D331$Я думал по другому.%I thought differently.%rus_eng%AEBAD71F-D6E0-4729-81A5-0948DE945AD9$Позволить кому то что то сделать.%Let somebody do something.%rus_eng%AF7DE37E-510D-4C8A-AFC7-6AD266387561$Он порезался%He cut himself%rus_eng%AF8693A7-EA7E-4130-9CD5-5C2544AF042B$Урок начался два часа назад(пол часа назад).%The lesson began two hours ago. (half an hour ago)%rus_eng%B077AD75-8AE5-430A-BE13-DA7B14D5F570$Полиция поймала вора%The police caught the thief.%rus_eng%B16EC359-71BB-490D-BAD8-561AC7A777AA$Я мечтал о различных вещах.%I dreamt about different things.%rus_eng%B1B7C9DB-73AC-4A3C-B0DA-3E6119FCF561$Воровать%Steal stole stolen%rus_eng%B34CFE96-9067-45CC-9E07-ADB6127E432E$Я уехал с России.%I left Russia.%rus_eng%B5030252-B1BE-46A0-AF06-A5A694BFBCFE$Он преподал мне урок%He taught me a lesson%rus_eng%B5895CFA-EAB2-4B1D-8B70-4B2BBDEBE6D8$Основал очень прибыльную компанию.%He set up a very profitable company.%rus_eng%B9EBFDDA-D323-41BF-963A-E128C55F3121$Я подержал ее сумку.%I held her bag.%rus_eng%BAB10580-7EE6-482A-BC98-7C2EB5EBD9FF$Она купила очень просторную квартиру.%She bought a very spacious flat.%rus_eng%BDAF4ABD-6382-4F04-8F90-7D5C7BB8398C$Кормить%Feed fed fed%rus_eng%BDB643BE-6F11-48B5-9F6D-DC42D019004F$Он принес эту вещь мне.%He brought this thing to me.%rus_eng%BDEA611A-4804-47A4-AA3A-F5247988CA0C$Он бросил в нее камень%He threw a stone at her%rus_eng%BE28769B-C8CD-4217-9C46-F8B4D6EAA115$Эта пара обуви подошла мне.%This pair of shoes fit me.%rus_eng%BF930A83-0649-462A-9C8E-C65E0DBAB31E$Я нашел свой бумажник.%I found my wallet.%rus_eng%C02E5556-BF61-48EF-B296-06890A8E92EC$Я полежал в кровати%I lay in bed%rus_eng%C0ACDA5D-F364-4409-834D-EBB074BDBFF5$Она солгала мне%She lied to me%rus_eng%C1380BB8-1498-4891-BC6F-E7C2E2DF3DDB$Встреча началась на много позже.%The meeting began much later.%rus_eng%C168EF66-1C11-4A96-B661-1A38A3ADC848$Я стал позади его.%I stood behind him.%rus_eng%C1F7E73B-353A-44B0-B80A-4EEE57DBC554$Это был огромный(громадный) успех.%It was a huge(tremendous) success.%rus_eng%C29E3B25-79C5-4727-ABAA-FE42AE793FBE$Забывать%Forget forgot forgotten%rus_eng%C31181E6-4BCE-4790-80D7-E1A2B8460930$Он дал эту вещь.%He gave this thing.%rus_eng%C5D562F8-6AB2-4621-BEB9-663BE4490EAA$Иметь дело%Deal dealt dealt%rus_eng%C6731D2D-EB61-4B7E-B3F5-6766082FE4CB$Ломать%Break broke broken%rus_eng%C80D84CD-ED57-46FE-BF13-F9C500817447$Он сохранил этот секрет.%He kept this secret.%rus_eng%C8AAA4DF-F70F-482D-919E-90485791AA01$Одалживать.%Lend lent lent%rus_eng%C8E4BCB3-D59D-473F-B78F-5247C52A0A8F$Она потерял свои ключи.%She lost her keys.%rus_eng%CB9896B9-4B6B-4AC4-8A0D-1AB3333742FA$Плавать%Swim swam swum%rus_eng%D0E8469C-111C-4615-9BF6-82A53C4AF594$Я тоже думал так.%I also thought so.%rus_eng%D1B7B5DE-EE46-4108-952E-FA6C8ECCD8D5$Читать%Read - read - read (Рид - рэд - рэд)%rus_eng%D2E99931-2811-496F-8EC9-9BBCC38BC8D1$Он выпил стакан воды.%He drank a glass of water.%rus_eng%D35D77ED-F107-4B9B-9941-DF7E70306930$Урок начался вовремя.%The lesson began on time.%rus_eng%D88A34C3-7593-4B0B-957F-234E94F47C83$Дуть%Blow blew blown%rus_eng%D92419F4-E714-4153-BCC6-D17CD81725E2$Терять%Lose lost lost%rus_eng%D98837DB-BC0B-4973-8ED8-E24BCAE4E978$Она носила очень дорогую одежду%She wore very expensive close%rus_eng%DAAEB26F-C876-4FCF-8EFC-B96CEF524FDF$Мы покинули англию.%We left England.%rus_eng%DB41D309-133F-477B-BDCD-7D48D3F7BACF$Она отправила мне сообщение%She sent me a message%rus_eng%DCB70E7B-2A8F-45D3-AE1E-05710B5DBD46$Лежать%Lie lay lain%rus_eng%DDC69B5E-8F17-4AFC-9857-B2AB35F25363$Намеревался(две формы)%Meant & intended%rus_eng%DE9283DE-B055-43E6-A7DB-C00C4D5F1E58$Выяснять%Found out%rus_eng%E136ECAB-C165-4E0C-841F-96A7B0606FA6$Учить%Teach taught taught%rus_eng%E22ED12C-CAAA-49D4-A134-F4DF54B712A4$Выигрывать%Win won won%rus_eng%E3FEB8A7-2C43-472B-9522-6E90389D2A7E$Я проснулся раньше чем обычно.%I woke up early/later than usually.%rus_eng%E433F77E-0692-4A98-A3FE-CEB0F4DC7FFC$Бросать%Throw threw thrown%rus_eng%E4EAF8E1-B345-4A21-BC19-C4C9F9E109A9$Я мог слушать ее делая другие вещи.%I could listen to her doing other things.%rus_eng%E507FA90-EB1C-4175-8380-18B0128AC20A$Я выбросил это%I threw it away%rus_eng%E761C6BF-AEE3-4ECE-B3AF-AA9455A22D80$Я простил ее%I forgave her%rus_eng%E804A36A-EFA5-4381-89F7-67808F1D01A1$Я вырос в америкe.%I grew up in america.%rus_eng%E90E0651-3DF1-4987-BD51-361E7BBD69E5$Начинаться.%Begin - began - begun.%rus_eng%E96C78AD-E5CE-4ED9-A2F7-8A295CA3B306$Носить%Wear wore worn%rus_eng%ED57662E-2A29-4AF2-9E89-1BC93348A3CF$Я поспал достаточно.%I slept enough.%rus_eng%EE15CA8A-7507-46F0-B4BF-3D3F86162A6D$Я катался на лошаде.%I rode a horse.%rus_eng%F0207949-94D8-4297-8E21-2C78594FAA91$Он сказал это тихо/громко%He said it quietly/ loudly%rus_eng%F069920E-5DFF-4F58-A0F5-9524DD1FB033$Спать%Sleep slept slept%rus_eng%F06F1CAB-BD05-4483-8DE6-F2CEBBD683D3$Встать.%Stand - stood - stood%rus_eng%F10EB147-9F04-4421-A786-28F7C51A9DF0$Она пела очень красиво.%She sang very beautiful.%rus_eng%F4044B4C-5C6A-4561-BD93-292A78F5F341$Он сьел бутерброд.%He ate a sandwich.%rus_eng%F4BAC421-CEA8-43D0-A2BC-5BED478B65C2$Просыпаться%Wake woke woken%rus_eng%F4CFF286-C238-4921-B0D7-90EDBDD2B50B$Она ушибла руку%She hurt her arm%rus_eng%F68C4080-A274-4A72-96C7-B77CA6799767$Мальчик показал выдающиеся результаты.%The boy showed the outstanding results.%rus_eng%F924BEEB-635A-493A-884B-D0B1E3B1983D$Я получил емэйл от нее.%I got an email from her.%rus_eng%FC215D61-2A65-4817-A187-BE8E2FB63FAE$Мы преодолели те трудности%We overcame those difficulties.%rus_eng%FD5F9175-E878-4BDD-B9F3-3C5FB446BC74$Она покормила кота.%She fed the cat.%rus_eng%FD885D4C-E1C0-4252-932B-C60A3C765606$Поехал в%Left for.%rus_eng%FE500655-3CB9-4407-BFD7-AF62663AED71$Я мог учить англ часами.%I could learn English for hours.%rus_eng%FFCB72D4-4192-4EE6-BD2F-11AF8BB01D20$Почему ты против этого?%Why are you against it?%rus_eng%01F0BF9D-E768-4CB8-AD3F-173AF072A36C$Этот результат впечатлит их?%Will this result impress them?%rus_eng%05BAFA9D-211A-468D-8C41-119F3EE5FD75$Тестовый%Bla%rus_eng%753B381D-7349-4217-9E97-783BC492CBCD$Мне кажется день не будет дождливым.%It seems to me the day won\'t be rainy.%rus_eng%CE40E116-66B4-486F-AC9B-E66C239A1F8A$Я ненавидел обсуждать это.%I hated discussing it.%rus_eng%01A30AF8-57B5-42A6-BE5F-2EFBCCA711CF$Тщательно%Thoroughly%rus_eng%06235067-8662-4678-B66E-EABBBC5B21AA$Вор%Thief%rus_eng%0BCE3527-0596-4895-A96F-568CCA04682C$Она предложила пойти в кино.%She suggested going to the cinema.%rus_eng%0C3DABDF-92C3-49C8-BE35-A3CA23875E7A$Я разделил это на 3 части.%I divided it into three parts.%rus_eng%0EA96453-0471-4EA5-9910-240E4769B121$Я решил сделать это.%I decided to do it.%rus_eng%1A1C1DE0-6ACB-4D43-8264-3FCB7C6EF0C1$Это привлекло наше внимание.%It attracted our attention.%rus_eng%1C10898E-060E-43B2-BC81-FF536A3D0C24$Он умыл свое лицо.%He washed his face.%rus_eng%206A583C-AC44-4125-8A06-B140B4203F4B$Он обещал нам сдержать свое слово.%He promised us to keep his word.%rus_eng%2614D49E-BA87-494C-B9C7-F08F6DAAE1C1$Мы переехали в лондон.%We moved to London.%rus_eng%2A326A3C-F50A-4DBB-9BED-6F9FE4678165$Он перепрыгнул через забор.%He jumped over the fence.%rus_eng%2A4BAC58-E508-4919-B2F3-67DB3F24265D$Он открыл америку.%He discovered America.%rus_eng%2B2AD813-5BA6-4C91-9252-D5DE86BF8469$Его речь вдохновила нас.%His speech inspired us.%rus_eng%2C4ECC2B-1D46-4920-985B-F384FECE217C$Мы доверяли ему полностью.%We trusted him completely.%rus_eng%361F45B5-E592-4125-A397-6C3147C51844$Она описала эту ситуацию.%She described this situation.%rus_eng%370AE26B-41DA-4970-A5A7-4701F1FB5217$Она описал ее внешность.%She described her appearance.%rus_eng%37A6E14A-4526-409F-A1F0-ABCD3662CD1A$Он пересек улицу.%He crossed the street.%rus_eng%3E26C4C9-93D8-47D1-9AA1-D62779F892BE$Он обычно молился утром.%He usually prayed in the morning.%rus_eng%4143E6B9-67CB-4D84-880E-EE4E180F0A9F$Мой двоюродный брат пожалел об этом.%My cousin regretted it.%rus_eng%41C88BBA-E969-490C-8518-6109D349B74A$Она помыла посуду.%She washed up the dishes.%rus_eng%41F61512-1B41-4CA0-91EF-22363A72C26D$Я заполнил эти документы.%I filled in these documents.%rus_eng%454DB950-A521-46CA-8CCA-5C47E2FF45FF$Он испытал так много трудностей.%He experienced so many difficulties.%rus_eng%46995DF4-A881-4B6E-B0BC-17AE6953B152$Я включил/выключил компьютер.%I turned on/off the computer. I switched on/off the computer.%rus_eng%4B6BC4DD-1694-4583-9E69-4DBFB53CF748$Она упустила ту возможность.%She missed that opportunity.%rus_eng%4FC51214-BDD4-48E3-B4F9-4D6E68441555$Предлагать делать что то.%Suggest doing something.%rus_eng%51F449B2-E54C-4D21-8A68-FE74C7AE205E$Я сконцентрировался на этой теме.%I concentrated on this topic.%rus_eng%53B463C6-F72D-4385-8C27-7DB1D84DD6D9$Я желаю вам большого успеха. Я чувствую вы этого заслуживаете.%I wish you a huge success.  I feel you deserve it.%rus_eng%54AA500B-16B0-484A-92BE-B6088E5CDF27$Там часто идет дождь/снег.%It often rained/snowed there.%rus_eng%5592CFCC-53F7-47B0-AF97-2570424DB43C$Мы столкнулись с очень большой проблемой.%We faced a very big problem.%rus_eng%56BBCB73-50EA-42E1-9C9A-A3ADA90577EC$Он приказал солдатам сделать это.%He ordered the soldiers to do it.%rus_eng%56D3A811-35AB-4F6B-BB97-3CAF61D24D9A$Мы пошли в парк.%We walked to the park. We went to the park on foot.%rus_eng%58B08827-67EB-4344-8CE4-7C940A640E3C$Он подтвердил свое решение.%He confirmed his decision.%rus_eng%5966BC98-1940-45E7-812F-C2838C214D91$Мы поторопились.%We hurried up.%rus_eng%5BF4270C-4541-4BF8-9CAF-562932A80002$Урок длился 2 часа.%The lesson lasted for 2 hours.%rus_eng%5E17D514-7DD8-4B3A-8D7F-A5D1FA185934$Это произошло случайно.%It happened by accident. (accidentally)%rus_eng%644FE096-C8D5-4AC6-AD46-1905F0DEA8E3$Он настоял чтобы сделать это.%He insisted on doing it.%rus_eng%6521FD30-ABAE-403B-9EFB-9CCA236B7072$Враг атаковал их.%The enemy attacked them.%rus_eng%6BE41CD8-1BAC-4EE4-AC8C-A3F132AF66E1$Это привлекло наше внимание сразу же.%It attracted our attention immediately /  at once.%rus_eng%6ECBEA5C-DFC3-432B-93D7-5F484B523862$Я надеялся получить ту работу.%I hoped to get that job.%rus_eng%6FE15CD5-2349-4DFB-A49C-26BB30C6B4B3$Я ответил на следующие вопросы.%I answered the following questions.%rus_eng%7404F88B-90E9-4588-95A7-79E03FE007C1$Мы склоны были считать это очень важным.%We tented to consider it very important.%rus_eng%762251BC-5903-480B-AF7B-21EB2D99A9EF$Я въехал/выехал туда в 3 часа дня.%I checked in/out at 3 o\'clock in the afternoon.%rus_eng%768ECEF5-F6E8-42DB-B58F-5B7198660C9D$Он настаивал на этом.%He insisted on it.%rus_eng%7AC8016D-C035-468B-896D-43A188BE247F$Он помолился святым.%He prayed to saints.%rus_eng%7AFF2619-A6D2-4629-8F3C-4E1FD594067D$Он приказал защищать их.%He ordered to defend them.%rus_eng%7E10D4D1-5928-4931-9ADD-52CBDAAFCA42$Они исчезли неожиданно.%They disappeared unexpectedly.%rus_eng%7F3EB775-E6CF-45F9-8A74-5735142FE205$Мне нужно было связаться с ней.%I needed to get in touch with her.%rus_eng%8117AA9D-92D9-4029-BBC3-562A11AA7930$Они отпраздновали свою годовщину.%They celebrated their anniversary.%rus_eng%8363B06B-B394-4B2A-BE60-E2210B4F4406$Мы включили его имя.%We included his name.%rus_eng%864DE476-8977-4909-B2B9-88B32B609E74$Мы ожидали эти результаты.%We expected these results.%rus_eng%86803BB7-1E2A-4CA9-A45D-195FC644F1AF$Он подтвердил дату нашей встрече.%He confirmed the date of our meeting.%rus_eng%871182E7-AE95-48F4-8271-3ADE0A628943$Я пожелал ему удачи.%I wished him good luck.%rus_eng%8DECECA4-52DF-4642-996B-D545E10F69F5$Он воображал различные вещи.%He imagined different things.%rus_eng%8F807F02-6FC5-4ABE-9A5A-EAF22DA48F95$Он заслуживал это.%He deserved it.%rus_eng%91BF169A-9D7B-4FF8-B440-B2A5D182CD13$Он отрицал свою вину.%He denied his guilt.%rus_eng%91C33C0F-A5A8-412A-80A5-3C14E9BA9D62$Его поведение казалось очень подозрительным.%His behave seemed very suspicious.%rus_eng%932FB908-C994-44D8-9494-4000ABF2B234$Мы считали эту победу очень важной.%We considered this victory very important.%rus_eng%97234D7D-D0A0-42C2-AE1B-62DA0DB44EF4$Я припарковался там.%I parked there.%rus_eng%98E2F978-B5F1-434E-82F0-C410D38D0B19$Они обвенили его в этом преступлении.%They accused him of this crime.%rus_eng%9AE0C3F3-C25F-4778-845D-52844F2F0157$Он курил достаточно редко.%He smoked quiet rarely.%rus_eng%9BDE0719-5FDA-4A4D-8178-95E9A3CF5A2D$Они предложили пойти в кино.%They suggested going to the cinema.%rus_eng%9DD8DEC3-9341-4FA9-87A3-2B58BE25E379$Я достиг этого результата.%I reached this result.%rus_eng%9F50732B-B1E5-4898-A730-4C1D9EC5464E$Они обеспечивали очень хорошие условия.%They provided very good conditions.%rus_eng%A0CFC6C2-0370-4068-BCB9-B60415CC2A23$Он постучал в дверь.%He knocked at/on the door.%rus_eng%A24EEE0A-31F5-4095-8291-5151A459F279$Мы конкурировали с несколькими большими компаниями.%We competed with several big companies.%rus_eng%A351766E-4BA3-4E5A-98AC-7DEACCD412C7$Он курил очень редко.%He smoked very rarely/seldom.%rus_eng%AC973C90-0DF0-4509-BE3F-29E1D77B354F$Этот дом принадлежал ей.%This house belonged to her.%rus_eng%ADFB8305-A29F-41D7-9A52-A525CB92850C$Они производили очень дорогие товары.%They produced very expensive goods.%rus_eng%AFC52128-FF29-4FEF-BFB0-BEF3EEEB9E62$Я часто был не согласен с ними без какой либо причины.%I often disagreed with them for no reason.%rus_eng%B1A2A509-C959-4AA3-B9EE-129DFEB0FC3D$Все осталось таким же.%Everything remained the same.%rus_eng%B7840767-A9AF-4884-B1AE-64AC6AA1E9E0$Это событие повлияло на меня.%This event influenced on me.%rus_eng%BA7E003F-FFA6-4F4D-9F6D-67502D3EFB9F$Я представил его им.%I introduced his to them.%rus_eng%BB4C763B-80BD-4BA0-8FDA-9AD38FE5189D$Мы считали это очень важным.%We considered it very important.%rus_eng%BD5A6DE9-985D-4D9F-B6B7-318A2E7E1D78$Он повернулся и улыбнулся ей.%He turned and smiled at her.%rus_eng%BD9CA73A-092D-4CB6-8FC0-EAB7EBD73411$Его поведение казалось очень подозрительным.%His behave seemed very suspicious.%rus_eng%BFE880FA-B59A-4F07-AEBD-4C71BCD74B70$Она частично согласилась со мной.%She partly agreed with me.%rus_eng%C05F362D-0B70-4F0B-A90E-CF0AD3628BF3$Мальчики вели себя очень плохо.%The boys behaved very badly.%rus_eng%C1896CAE-851D-4FF6-B20F-B1A12FC199A1$Он вошел в сдание.%He entered the building.%rus_eng%CA66326D-E702-4A72-8FE2-E4549728CCA0$Мы упаковали эту посылку. %We packed this parcel.%rus_eng%D397AEC5-92D5-476A-AA1E-92FBBB96DB5F$Они предложили нам что то особенное.%They offered us something special.%rus_eng%DA096C69-E304-4A4B-AD88-9A461B87E0E9$Тот мужчина спас ее жизнь.%That man saved her life.%rus_eng%DF3BECB3-734D-4BD2-AA20-2755A8F7CF6A$Они исчезли вдруг.%They disappeared suddenly.%rus_eng%E320AEEB-5A1B-4D82-ADFC-8503B4907AE6$Это требовало больше усилий.%It required more efforts.%rus_eng%E3278226-CEC6-44D8-9197-9CDBF90F4A12$Он заработал больше чем 500 долларов.%He earned more than 500 $%rus_eng%E39FB364-D408-445F-9A16-5F3D88EE5BF6$Он пригласил нас на свое день рождение.%He invited us to his birthday.%rus_eng%E417429C-9EAD-4EFB-BA89-F9A3630C8E40$Они разрушили сдание.%They destroyed the building.%rus_eng%E56146AA-D0E9-4F27-9D4A-9F238DBD53D6$Он отрицал все обвинения.%He denied all the accusations.%rus_eng%E5A61629-5F90-4424-AD3F-A1FA453EB1FA$Они предложили мне высокооплачиваемую работу.%They offered me a well-payed job.%rus_eng%E8DA58CD-4E4D-4621-BB69-C6F38F8DCF7C$Я упомянул это во время нашего разговора.%I mentioned it during our conversation / talk.%rus_eng%EFD45DC9-061B-4A62-840D-4FB2A892D8EA$Я повторил твои уроки еще раз.%I revise your lessons one more time.%rus_eng%F764BEB0-5719-46C6-BF05-EFC79B68C995$Я пользовался интернетом практически каждый день.%I used the internet almost every day.%rus_eng%F7772EED-BA6F-4FF1-ABDF-701EDE9F7ECF$Я остался спокойным.%I remained calm.%rus_eng%F82583ED-7DB2-48A2-9EDB-D73FEFBC2FA7$Она задала ему пару вопросов.%She asked him a couple of questions.%rus_eng%F882B4D5-1982-4630-B462-4D6130DEBD70$Я склонен был думать так.%I tented to think so.%rus_eng%F97192DA-C83C-46A7-ABF4-0E6894F12676$Он перебил наш разговор.%He interrupted our conversation/ talk.%rus_eng%FD192889-C6E3-40ED-81D1-806E2FBF7C08$Он пожалел об этом.%He regretted it.%rus_eng%FE9B71CC-3C57-4F90-B448-3C0C9628C3F1$Они убивали невинных людей.%They killed innocent people.%rus_eng%FF447FC3-82A7-4D1F-A71F-3D62CC46067C$Это изменило мое отношение к ней.%It change my attitude to her.%rus_eng%FFB8345E-25EF-4E31-84B7-5BB985D35395$Услышать.%Hear - heard - heard.%rus_eng%03838320-849F-4BD9-AFFF-F6948A5EE02C$Приносить.%Bring - brought- brought.%rus_eng%03864C3B-5E2E-488E-A3E2-63B5C54074C6$Бросать%Throw threw thrown%rus_eng%07422A50-1CB4-40E0-BCB5-71FAFDA4EA41$Находить%Find - found - found%rus_eng%14F43BCB-CB98-41F1-AAAB-11DCA81A078F$Есть%Eat ate eaten%rus_eng%15EC9506-552C-498F-BCAE-1EBEC82C215D$Воровать%Steal stole stolen%rus_eng%1824DACF-3CAA-4B1E-B87D-6DAE91C72934$Значит.%Mean - meant - meant.%rus_eng%1AABD4F0-5E42-4176-AB5E-8F5DBE34ABEC$Становиться%Become - became - become%rus_eng%1DB5583C-73C2-4A7D-BDA6-D71CD775B866$Капать%Dig dug dug%rus_eng%239C98BF-7A60-4B57-8794-632DFC8409D5$Мечтать%Dream - dreamt - dreamt(может быть правильным dreamed)%rus_eng%25FCD488-D2A7-43A8-832F-2E55AEE84FA1$Хранить%Keep kept kept%rus_eng%2CE8D65C-52CF-414F-A864-A161F6AE22DC$Выяснил%Found out%rus_eng%3155D895-FD9C-45FC-AAAF-C19BF20678EE$Преодолевать%Overcome - overcame - overcome%rus_eng%3185187B-290C-4591-B6A3-15788817A932$Поставить%Lay laid laid(set, put)%rus_eng%398AE249-0606-46C6-AB3D-B6C33C27AECE$Позволять.%Let - let - let.%rus_eng%3BDDB107-D69B-47B4-B7FA-51F4B71D0EB1$Лгать%Lie lied lied%rus_eng%419470F1-4461-4D50-ACDC-8165D22C02C9$Давать%Give - gave - given%rus_eng%45C1D531-1E1B-497F-B7C0-4F07151D21D9$Показывать.%Show - showed - shown.%rus_eng%4B0291FA-C735-4D60-8EED-D3167A9FDA0E$Иметь дело%Deal dealt dealt%rus_eng%4B5EF7AF-F8B5-4410-B84C-C42C8CA1AFC8$Встать.%Stand - stood - stood%rus_eng%4C95A8C9-A205-4928-BBEE-7003549F0FDA$Думать%Think - thought- thought%rus_eng%4D33412A-4030-4D8F-A450-DC648B993477$Драться%Fight fought fought%rus_eng%52300E37-3CC9-42F6-AFC5-68EF3AC41A7E$Сидеть%Sit - sat - sat%rus_eng%58BCD8DD-4C3C-47FA-9167-12567C0FD470$Терять%Lose lost lost%rus_eng%59D0F2AB-1150-4BDE-B575-303143FD46F1$Читать%Read - read - read (Рид - рэд - рэд)%rus_eng%5CA7088F-FC34-48A8-AF49-959336EEACE0$Держать(руками например)%Hold held held%rus_eng%5E43F525-3870-47F0-A319-C7277568D260$Тратить%Spend spent spent%rus_eng%63526092-A631-4D91-BE0E-E95103E16171$Кататься%Ride rode ridden%rus_eng%6D93EA3C-EE41-4E9B-AD40-EA108B56477B$Учить%Learn learnt learnt Learned learned%rus_eng%6E5895B6-D095-4CA1-892A-5FD97D5B20AC$Покидать.%Leave - left - left.%rus_eng%6EE5510C-54D7-4217-A762-F3FB7D7E61B1$Лежать%Lie lay lain%rus_eng%7454B1DF-5E58-4794-806A-3C60B9610ACA$Прятаться%Hide hid hidden%rus_eng%76B8A4C6-1920-4FD1-9092-CF37B03EDA9B$Одалживать.%Lend lent lent%rus_eng%79718F03-5F19-40C0-B478-995F7A2BB061$Ставить%Put - put - put%rus_eng%7B546C83-7BFE-4E88-A8F9-62A7171DDA9D$Начинаться.%Begin - began - begun.%rus_eng%7BB35FB3-D2B2-4E07-9089-8546705E22F7$Отправлять%Send sent sent%rus_eng%7C22848D-200F-473B-B08F-35CFDAEEC815$Расти, выращивать%Grow grew grown%rus_eng%8430AB5E-6B38-4AA3-AC2B-07081821AB51$Встречать%Meet - met - met%rus_eng%8670F7C7-AE33-4779-88D1-E6EF7130D9EC$Продовать%Sell sold sold%rus_eng%8AEEB4D4-1CC5-46CF-83D8-66A643965A02$Дуть%Blow blew blown%rus_eng%8E22B73B-6FC7-4891-8995-7444CA30259C$Учить%Teach taught taught%rus_eng%8ED591FB-7B0B-4881-BE95-EBE3D8856A06$Прощать%Forgive forgave forgiven%rus_eng%90121CFE-74C4-4B5D-A137-0FD3851753ED$Ломать%Break broke broken%rus_eng%9632C04D-805A-4BD2-8229-8B9B17EAB266$Поставил, установил%Set set set%rus_eng%96BD2025-38A4-45F9-ACFA-DC5060269DE8$Сказать кому то%Tell - told - told%rus_eng%986B6032-F138-44DD-834E-1ACFC204C56F$Ловить%Catch - caught caught%rus_eng%99BF6FA7-8580-48B9-8F78-DAF9858CCB10$Выигрывать%Win won won%rus_eng%9DAE242E-FD5D-4F65-B7B9-8AE1DDADD38A$Пить%Drink drank drunk%rus_eng%9E1551D5-33F9-41E2-9A85-3FEB0157AAF9$Купить%Buy bought bought%rus_eng%A3B9DE84-A104-4986-B9FF-285893F1C955$Могу%Can - could%rus_eng%A5599F34-102F-45A4-8077-7EC4C925618D$Бежать%Run ran run%rus_eng%A5FD136B-F8F1-4C67-991E-BC67F493547F$Просыпаться%Wake woke woken%rus_eng%A8B4A75E-FE43-45EB-81DD-20AD193A7E09$Сделал%Make - made - made%rus_eng%A92082CB-2281-4B4E-A3D5-8B35D768ED89$Понимать%understand - understood - understood%rus_eng%AAD56546-0D01-4F5D-B573-9CBD2DE1DEFB$Получать%Get - got - got%rus_eng%AE223936-8D33-4F40-B86F-BD8D8DFCF40E$Ушибить, задеть%Hurt hurt hurt (injured правильная форма)%rus_eng%AE64E8D7-4EF3-4EF6-B611-0DBA68CD4238$Плавать%Swim swam swum%rus_eng%BC9D93BA-F353-447B-ABA9-B3CFF150E257$Ударить%Hit hit hit%rus_eng%BDB0AB9C-B608-487F-A258-06BB8B5EA90F$Петь%Sing sang sung%rus_eng%C801F970-8E67-4056-9FA6-1B4F2BD74934$Забывать%Forget forgot forgotten%rus_eng%CBE5DD2B-38DD-44B3-9BCA-904AFDA7B1FC$Спать%Sleep slept slept%rus_eng%CF52F92A-3078-4688-AAB9-C377FA6DA206$Кормить%Feed fed fed%rus_eng%D3FCFA48-280B-45EB-8C8B-71C599887760$Чувствовать%Feel - felt - felt%rus_eng%D54D21AC-38D8-4CF2-9474-6145566626FA$Писать.%Write - wrote - written.%rus_eng%D6BC7F3C-AB28-483B-8235-50EE925826F4$Летать%Fly flew flown%rus_eng%D8B435EF-41D9-438D-B6AF-A6EE1897BAD4$Быть%Be, was - he, she, it, were%rus_eng%E18811AD-EF4D-40EA-8B7E-EA1F4BF5338E$Подходить%Fit fit fit%rus_eng%E18C9A2D-9CAD-424A-9D62-D53A535FD178$Носить%Wear wore worn%rus_eng%E1C183F1-3B17-4224-90D0-85D2D6352871$Падать%Fall fell fallen%rus_eng%E4A8FDF8-EA23-49B4-993E-EA96758D95FA$Рисовать%Draw drew drawn%rus_eng%EA762BCA-FE20-4743-8979-3EBD706DC980$Знать%Know- knew - known%rus_eng%ED5AA31D-C259-4155-A014-425137FD5C6C$Идти%Go - went - gone%rus_eng%EFBFB2D4-7528-4E12-A3DA-FC1471637DB6$Платить%Pay paid paid%rus_eng%F2EE3D19-CAFB-427B-917B-F3C9A7692F23$Резать%Cut - cut - cut%rus_eng%F3744556-1A30-4431-A09D-8BD0EC53E724$Сказать -%Say - said - said%rus_eng%F7E4CAA8-1BCB-4B1B-BE2D-EE653996269C$Меры%Measures%rus_eng%0728A9EC-C865-4909-BF64-1100BBEE53F7$Неудобный.%Inconvenient.%rus_eng%2C22AFE4-7098-4D14-8E51-D9DA0535F56C$Принимать серьезные меры.%Take serious measures.%rus_eng%C21153C7-4C52-46C8-AF46-D7AF9C250E9B$Они будут вести себя более осторожнее.%They\'ll behave more carefully.%rus_eng%028EAAF9-F877-4709-B98A-6E21A2510195$Неудобный.%Inconvenient.%rus_eng%04C13020-ED0C-4E9B-9076-A32660CEAF71$Как долго твои родители будут отсутствовать?%How long will your parents be away?%rus_eng%06BFBF0F-646F-45FB-8F58-968E75C52AB3$Он не будет курить больше.(дольше)%He won’t smoke anymore.(any longer)%rus_eng%0790BEEA-2E2C-444E-8006-652F1C4A6F4D$Это требовало больше усилий.%It required more efforts.%rus_eng%09B38EA0-80C2-42BA-A72F-0747527FDCD8$Они обвенили его в этом преступлении.%They accused him of this crime.%rus_eng%11210983-757E-4320-8CC4-A250B9D2832E$Это не принесет тебе больше денег.%It won\'t bring you more money.%rus_eng%132809CE-6CEB-45D2-B3AD-352354BDCDB8$Это произошло случайно.%It happened by accident. (accidentally)%rus_eng%18E96CC4-9620-43AF-8CB5-4EE5155FE081$Он подтвердил свое решение.%He confirmed his decision.%rus_eng%1B1C9976-F751-44C0-BEF6-F92EBDB31C2C$Этот подход не будет достаточно инновационным.%This approach won\'t be innovative enough.%rus_eng%1FA9DDCD-16FD-4985-B0CF-9FAE50B0BC8A$Он курил достаточно редко.%He smoked quiet rarely.%rus_eng%21CEB6AE-1A20-4420-A55C-CDCA59FCA25A$Я думаю нам не нужно изобретать заново колесо.%I think we don\'t need to reinvent the wheel.%rus_eng%2C49FA5D-A349-40FB-8C72-292EF1E1F323$Это будет длиться вечно?%Will it last forever?%rus_eng%2D377FEB-549B-4E1A-90BE-810D29143D6B$Все осталось таким же.%Everything remained the same.%rus_eng%2D90FD92-64C9-4E29-9031-C843E53B85CD$Мы склоны были считать это очень важным.%We tented to consider it very important.%rus_eng%30B91A37-0FE5-418D-AE6B-87F38A0E0BC7$Учитель простит ему.%The teacher will forgive him.%rus_eng%3380DDF6-EBF7-4595-84EF-438B8F76CAAB$Каким видео ты восхищаешься больше?%Which video do you admire more.%rus_eng%38AE7C1C-9EBC-4A7B-A482-72D528AD62CE$Я повторил твои уроки еще раз.%I revise your lessons one more time.%rus_eng%3D4DF2CF-6AB3-49AD-A4DE-A9ED555AA557$Они отпраздновали свою годовщину.%They celebrated their anniversary.%rus_eng%445D80E3-A18F-4CC5-A17C-8E5529F925D2$Она упустила ту возможность.%She missed that opportunity.%rus_eng%4742991A-8F92-42E3-A36E-D827547227FF$Студенты посмотрят это в словаре?%Will the students look it up in a dictionary?%rus_eng%4AE6BDAF-124F-4994-A16B-654B0BEACD24$Этот результат впечатлит их?%Will this result impress them?%rus_eng%51086C73-3065-435E-8876-E58890B7752F$Принимать серьезные меры.%Take serious measures.%rus_eng%645399F9-DC28-42E7-902E-963E5112B48A$Он отсутствует.%He is away.%rus_eng%6554A6FB-0602-4993-9AEA-EBB19C92A9F1$Я сумею удвоить наши продажи, не смотря на кризис.%I\'ll manage to double our sales, despite (in spite of) the crisis.%rus_eng%6D7CD0AC-B9BC-4D89-B7C0-2AD0A6078B7A$Мой бизнес партнер отдолжит ему эту сумму денег.%My business partner will lend him this sum of money.%rus_eng%6FAE28CC-D9D3-40BA-B5E7-12018AF091DF$Это событие повлияло на меня.%This event influenced on me.%rus_eng%760C8584-15CA-4285-99AF-ECC066BD5E53$Привести к успеху.%Lead to success.%rus_eng%7F12934D-AF8E-4DDC-8547-DFAADC2BC7A4$Я желаю вам большого успеха. Я чувствую вы этого заслуживаете.%I wish you a huge success.  I feel you deserve it.%rus_eng%8454B823-6FA9-474D-83D6-1D6864C71CD2$Я думаю он будет обожать спорт, но это не обязательно означает, что он станет профессиональным спортсменом.%I think he\'ll fond of sport but it doesn\'t necessarily mean that he\'ll became a professional sportsman.%rus_eng%94C4BBCC-5F51-4639-8405-E8B824A107EB$Он настоял чтобы сделать это.%He insisted on doing it.%rus_eng%9737BFE6-EEFA-4416-BEF8-EC1A596B795E$Он приказал защищать их.%He ordered to defend them.%rus_eng%A2AF9A84-3703-4386-91BC-D57F81FF839A$Они убивали невинных людей.%They killed innocent people.%rus_eng%A5C09E90-14B6-4264-8274-3ACE6C36C7AA$Мой босс не будет настраиваться на это.%My boss won\'t insist on it.%rus_eng%AB99EB12-2F02-4531-82FA-83A0F00D6E8E$Жизнь накажет его.%Life will punish him.%rus_eng%AD036211-068E-43F5-9363-59703684940E$Я постараюсь не делать это.%I\'ll try not to do it.%rus_eng%B00BCC15-7626-4DF4-A208-481128827D8A$Сколько денег ее муж будет должен им?%How much money will her husband owe them?%rus_eng%B449ED10-533D-457F-887F-A0968C3580C5$Это наш последний шанс.%It\'s our last chance. (чанс)%rus_eng%B5877E96-7CB9-4108-941C-ACC1E84A3358$Я достигну этой цели.%I\'ll achieve this aim.%rus_eng%BA8D9F7F-C53A-436E-9351-A8F0996D623D$Эти условия подойдут нам.%This conditions will suit us.%rus_eng%C345820E-92B9-440A-8B9C-99C118973F2A$Я склонен был думать так.%I tented to think so.%rus_eng%C8722676-AE0F-4D19-B457-E68DB95C207E$Предлагать делать что то.%Suggest doing something.%rus_eng%C990E979-D434-4E1B-9274-58260A2B8E15$Я достиг этого результата.%I reached this result.%rus_eng%CAE64EC9-5692-474B-A093-7C2FFA64EADE$Мы с моим другом будем уделять английскому/здоровью больше свободного времени.%My friend and i will devote more free time to English/ health.%rus_eng%CCD38D49-F89D-4381-A206-63E38519D685$Это будет длиться вечно?%Will it last forever?%rus_eng%D2BE4D66-55CB-48DF-B00D-5F00292E2460$Мы обдумаем это.%We\'ll think it over.%rus_eng%D3B32771-E279-404A-84D2-61A55DCC55F3$Мы будем благодарны тебе за это.%We\'ll be grateful to you for it.%rus_eng%D61CBF31-AA34-4133-84B3-0B32D043202D$Он отрицал свою вину.%He denied his guilt.%rus_eng%D6B7E254-73AD-489C-A9D9-20834403C64A$Студент отгадает правильный ответ?%Will the student guess the correct answer?%rus_eng%D7735B11-EA2F-43C2-A6E3-5A7C92020244$Это изменило мое отношение к ней.%It changed my attitude to her.%rus_eng%E303B0B3-23E3-426F-9607-BD17FE46D05C$Мы считали эту победу очень важной.%We considered this victory very important.%rus_eng%FA9242B2-7601-4855-BD97-DB67EDD113F8$Я буду гордится вашими результатами.%I will be proud of your results.%rus_eng%FECCD1FF-4DC9-4A03-85D5-C9BFE0B0D6F9"
 */
}

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

