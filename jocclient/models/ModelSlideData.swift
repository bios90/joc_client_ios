import Foundation

class ModelSlideData
{
    let title:String
    let text:String?
    let image:MyImage
    
    init(title:String,text:String?,image:MyImage)
    {
        self.title = title
        self.text = text
        self.image = image
    }
    
    static func getSlidesData()->[ModelSlideData]
    {
        let slide_1 = ModelSlideData(title: "Добро пожаловать в JOC", text: nil, image: .img_intro1)
        let slide_2 = ModelSlideData(title: "Удобно", text: "Выберете подходящее заведение в списке или на карте. Используйте фильтр по рейтингу и стоимости для подбора лучшего варианта.", image: .img_intro2)
        let slide_3 = ModelSlideData(title: "Быстро", text: "Делайте заказ к определённому времени или прямо сейчас, забудьте об очередях и трате времени.", image: .img_intro3)
        let slide_4 = ModelSlideData(title: "Отзывы", text: "Оценивайте заказы, делитесь впечатлениями о заведении.", image: .img_intro4)
        let slide_5 = ModelSlideData(title: "Безопасно", text: "Сервис позволяет минимизировать время в  местах распространения инфекции.", image: .img_intro5)
        
        return [slide_1,slide_2,slide_3,slide_4,slide_5]
    }
}
