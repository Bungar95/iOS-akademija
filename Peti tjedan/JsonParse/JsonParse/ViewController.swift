//
//  ViewController.swift
//  JsonParse
//
//  Created by Borna Ungar on 16.06.2021..
//

import UIKit

enum DataType {
    case counties
    case health
    case babyNames
    case activities
    case articles
    case articlesChild
    case fertiliser
    case fields
    case jobList
    case jobSingle
    case product
    case user
    case encoding
}

class ViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData(for: .counties)
    }
    
    private func setupUI(){
        title = "JSON parse"
        view.backgroundColor = .white
        view.addSubview(label)
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
        
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    private func getData(for type: DataType) {
        switch type {
        case .counties:
            getCounties()
        case .health:
            getHealth()
        case .babyNames:
            getBabyNames()
        case .activities:
            getActivities()
        case .articles:
            getArticles()
        case .articlesChild:
            getArticlesChilds()
        case .fertiliser:
            getFertiliser()
        case .fields:
            getFields()
        case .jobList:
            getJobList()
        case .jobSingle:
            getSingleJob()
        case .product:
            getProduct()
        case .user:
            getUser()
        case .encoding:
            doSomeEncoding()
        }
    }
}
// MARK: counties_list.json
extension ViewController {
    private func getCounties() {
        if let localData = self.readLocalFile(forName: "counties_list"),
           let responseData: Response<CountyGroup> = parse(jsonData: localData),
            let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleCounties(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<CountyGroup>){
        if let status = data.status { print("Status: \(status)") }
        print("\n")
    }
    
    private func handleCounties(data: CountyGroup) {
        
        print("\tCurrent page: \(data.currentPage)\n")
        var counties = [String]()
        data.county.forEach { (county) in

            print("\t\tId: \(county.id)")
            print("\t\tName: \(county.name)")
            print("\t\tCountry: \(county.country)")
            counties.append(county.name)
            print("\n")
        }
        print("\tFirst page url: \(data.firstPageUrl)")
        print("\tFrom: \(data.from)")
        print("\tLast page: \(data.lastPage)")
        print("\tLast page url: \(data.lastPageUrl)")
        if let nextPageUrl = data.nextPageUrl{
            print("\tNext page url: \(nextPageUrl)")
        }
        print("\tPath: \(data.path)")
        print("\tPer page: \(data.perPage)")
        if let prevPageUrl = data.prevPageUrl{
            print("\tPrevious page url: \(prevPageUrl)")
        }
        print("\tTo: \(data.to)")
        print("\tTotal: \(data.total)")

        label.text = "Counties: \n\(counties.joined(separator: ",\n"))"
    }

}
// MARK: data_success_response.json
extension ViewController {
    private func getHealth() {
        if let localData = self.readLocalFile(forName: "data_success_response"),
           let responseData: Response<[HealthStats]> = parse(jsonData: localData),
           let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleHealth(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<[HealthStats]>){
        if let api = data.apiVersion { print("Api version: \(api)") }
        if let context = data.context { print("Context: \(context)") }
        if let httpCode = data.httpCode { print("HTTP code: \(httpCode)") }
        if let method = data.method { print("Method: \(method)") }
        if let baseUrl = data.baseUrl { print("Base URL: \(baseUrl)") }
        if let uri = data.uri { print("URI: \(uri)") }
        if let parameters = data.queryParameters {
            print("Query parameters: \(parameters)")
        } else { print("[ ]") }
        print("\n")
    }
    
    private func handleHealth(data: [HealthStats]) {
            
        data.forEach{ (stats) in
            
            print("\tWeight: \(stats.weight)")
            print("\tDate: \(stats.date)")

            if let diabetes = stats.diabetes{
                print("\tDiabetes: \(diabetes)")
            }
            if let diastolic = stats.diastolicBp{
                print("\tDiastolic BP: \(diastolic)")
            }
            if let systolic = stats.systolicBp{
                print("\tSystolic BP: \(systolic)")
            }
            print("\n")
        }
    }
}
// MARK: get_baby_names_country_success.json
extension ViewController {
    private func getBabyNames() {
        if let localData = self.readLocalFile(forName: "get_baby_names_country_success"),
           let responseData: Response<Favorites> = parse(jsonData: localData),
           let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleFavorite(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<Favorites>){
        if let api = data.apiVersion { print("Api version: \(api)") }
        if let context = data.context { print("Context: \(context)") }
        if let httpCode = data.httpCode { print("HTTP code: \(httpCode)") }
        if let method = data.method { print("Method: \(method)") }
        if let baseUrl = data.baseUrl { print("Base URL: \(baseUrl)") }
        if let uri = data.uri { print("URI: \(uri)") }
        if let parameters = data.queryParameters {
            print(parameters)
        } else { print("[ ]") }
        print("\n")
    }
    
    private func handleFavorite(data: Favorites) {
            
        data.favorites.forEach{ (favorite) in
            
            print("\tID: \(favorite.id)")
            print("\tName: \(favorite.name)")
            print("\tCountry: \(favorite.country)")
            print("\tIs favorite: \(favorite.isFavorite)")
            
            print("\n")
        }
    }
}

// MARK: activities_list.json
extension ViewController {
    private func getActivities() {
        if let localData = self.readLocalFile(forName: "article_get_success"),
           let responseData: Response<[Activity]> = parse(jsonData: localData),
           let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleActivity(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<[Activity]>){
        if let api = data.apiVersion { print("Api version: \(api)") }
        if let context = data.context { print("Context: \(context)") }
        if let httpCode = data.httpCode { print("HTTP code: \(httpCode)") }
        if let method = data.method { print("Method: \(method)") }
        if let baseUrl = data.baseUrl { print("Base URL: \(baseUrl)") }
        if let uri = data.uri { print("URI: \(uri)") }
        if let parameters = data.queryParameters {
            print(parameters)
        } else { print("[ ]") }
        print("\n")
    }
    
    private func handleActivity(data: [Activity]) {
            
        data.forEach{ (activity) in
            print("Id: \(activity.id)")
            if let typeId = activity.type.id {
                print("Type: \n\t\(typeId)")
            }
            if let typeName = activity.type.name {
                print("Type: \n\t\(typeName)")
            }
            if let typeSlug = activity.type.slug {
                print("Type: \n\t\(typeSlug)")
            }
            if let typeType = activity.type.type{
                print("Type: \n\t\(typeType)")
            }
            if let typeQ = activity.type.showQuantityAndUnit {
                print("Type: \n\t\(typeQ)")
            }

            print("Crop: \n\t\(activity.crop.id)")
            print("\t\(activity.crop.name)")
            print("\t\(activity.crop.slug)")
            print("Field: \n\t\(activity.field.id)")
            print("\t\(activity.field.name)")
            print("\t\(activity.field.surface)")
            print("\t\(activity.field.unit)")
            print("\t\(activity.field.arCode)")
            print("\t\(activity.field.surfaceInM2)")
            print("Value: \(activity.value)")
            print("Currency: \(activity.currency)")
            print("Quantity: \(activity.quantity)")
            print("Unit: \n\t\(activity.unit)")
            print("\t\(activity.date.display)")
            print("\t\(activity.date.date)")
            print("\t\(activity.date.datetime)")
            print("\t\(activity.date.timestamp)")
            print("\t\(activity.date.datepickerFormat)")
            print("\n")
            
        }
    }
}

// MARK: article_get_success.json

extension ViewController {
    private func getArticles() {
        if let localData = self.readLocalFile(forName: "article_get_success"),
           let responseData: Response<Article> = parse(jsonData: localData),
           let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleArticle(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<Article>){
        if let api = data.apiVersion { print("Api version: \(api)") }
        if let context = data.context { print("Context: \(context)") }
        if let httpCode = data.httpCode { print("HTTP code: \(httpCode)") }
        if let method = data.method { print("Method: \(method)") }
        if let baseUrl = data.baseUrl { print("Base URL: \(baseUrl)") }
        if let uri = data.uri { print("URI: \(uri)") }
        if let parameters = data.queryParameters {
            print(parameters)
        } else { print("[ ]") }
        print("\n")
    }
    
    private func handleArticle(data: Article) {
            
        print(data)
    }
}

// MARK: articles_child_get.json

extension ViewController {
    private func getArticlesChilds() {
        if let localData = self.readLocalFile(forName: "articles_child_get"),
           let responseData: Response<[ArticleChild]> = parse(jsonData: localData),
           let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleArticleChild(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<[ArticleChild]>){
        if let api = data.apiVersion { print("Api version: \(api)") }
        if let context = data.context { print("Context: \(context)") }
        if let httpCode = data.httpCode { print("HTTP code: \(httpCode)") }
        if let method = data.method { print("Method: \(method)") }
        if let baseUrl = data.baseUrl { print("Base URL: \(baseUrl)") }
        if let uri = data.uri { print("URI: \(uri)") }
        if let parameters = data.queryParameters {
            print(parameters)
        } else { print("[ ]") }
        print("\n")
    }
    
    private func handleArticleChild(data: [ArticleChild]) {
            
        print(data)
    }
}

// MARK: fertiliser_result.json

extension ViewController {
    private func getFertiliser() {
        if let localData = self.readLocalFile(forName: "fertiliser_result"),
           let responseData: Response<[Fertiliser]> = parse(jsonData: localData),
           let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleFertiliser(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<[Fertiliser]>){
        if let httpCode = data.httpCode { print("HTTP code: \(httpCode)") }
        if let message = data.message {
            print("Message: \(message)") }
        if let method = data.method { print("Method: \(method)") }
        if let baseUrl = data.baseUrl { print("Base URL: \(baseUrl)") }
        if let uri = data.uri { print("URI: \(uri)") }
        if let parameters = data.queryParameters {
            print(parameters)
        } else { print("[ ]") }
        print("\n")
    }
    
    private func handleFertiliser(data: [Fertiliser]) {
            
        print(data)
    }
}

// MARK: fields_response.json

extension ViewController {
    private func getFields() {
        if let localData = self.readLocalFile(forName: "fields_response"),
           let responseData: Response<[ActivityField]> = parse(jsonData: localData),
           let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleFields(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<[ActivityField]>){
        if let httpCode = data.httpCode { print("HTTP code: \(httpCode)") }
        if let message = data.message {
            print("Message: \(message)") }
        if let method = data.method { print("Method: \(method)") }
        if let baseUrl = data.baseUrl { print("Base URL: \(baseUrl)") }
        if let uri = data.uri { print("URI: \(uri)") }
        if let parameters = data.queryParameters {
            print(parameters)
        } else { print("[ ]") }
        if let errors = data.errors { print("Errors: \(errors)")}
        print("\n")
    }
    
    private func handleFields(data: [ActivityField]) {
            
        print(data)
    }
}

// MARK: job_list_response.json

extension ViewController {
    private func getJobList() {
        if let localData = self.readLocalFile(forName: "job_list_response"),
           let responseData: Response<JobsList> = parse(jsonData: localData),
           let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleJobList(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<JobsList>){
        if let status = data.status { print("Status: \(status)") }
    }
    
    private func handleJobList(data: JobsList) {
            
        print("\tCurrent page: \(data.currentPage)")
        
        data.jobs.forEach{ (job) in
            print("\tID: \(job.id)")
            print("\tTitle: \(job.title)")
            print("\tJob link: \(job.jobLink)")
            print("\tPoslodavac info: \(job.user)")
            print("\n")
            
        }
    }
}

// MARK: job_single_response.json

extension ViewController {
    private func getSingleJob() {
        if let localData = self.readLocalFile(forName: "job_single_response"),
           let responseData: Response<Job> = parse(jsonData: localData),
           let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleJob(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<Job>){
        if let status = data.status { print("Status: \(status)") }
    }
    
    private func handleJob(data: Job) {
            
        print("\tID: \(data.id)")
        print("\tTitle: \(data.title)")
        print("\tJob link: \(data.jobLink)")
        print("\tPoslodavac info: \(data.user)")
        print("\n")
    }
}

// MARK: product.json
extension ViewController {
    private func getProduct() {
        if let localData = self.readLocalFile(forName: "product"),
           let responseData: Response<Product> = parse(jsonData: localData),
           let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleProduct(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<Product>){
        if let httpCode = data.httpCode { print("HTTP code: \(httpCode)") }
        if let message = data.message { print("Message: \(message)") }
        if let method = data.method { print("Method: \(method)") }
        if let baseUrl = data.baseUrl { print("Base URL: \(baseUrl)") }
        if let uri = data.uri { print("URI: \(uri)") }
    }
    
    private func handleProduct(data: Product) {
            
        print(data.id)
        print(data.name)
        print(data.shortDescription)
        print(data.fullDescription)
        print(data.group)
        print(data.packageUnit)
        print(data.isOrganic)
        print(data.thumbnail)
        print(data.image)
        print(data.leaflet)
        print(data.updatedAt)
        
    }
}

// MARK: user_response.json
extension ViewController {
    private func getUser() {
        if let localData = self.readLocalFile(forName: "user_response"),
           let responseData: Response<User> = parse(jsonData: localData),
           let data = responseData.data {
            handleRootObjectInfo(data: responseData)
            handleUser(data: data)
        }
    }
    
    private func handleRootObjectInfo(data: Response<User>){
        if let status = data.status { print("Status: \(status)") }
    }
    
    private func handleUser(data: User) {
         
        //print(data)
        print(data.id)
        print(data.firstName)
        print(data.lastName)
        print(data.email)
        
        data.skills?.forEach{ (skill) in
            print(skill)
        }
        
    }
}

extension ViewController {
    private func doSomeEncoding(){
        let food = FoodOnMyTable(name: "Pudding", status: "eaten", rating: 5)
        let food2 = FoodOnMyTable(name: "Pringles Hot&Spicy", status: "eaten", rating: 8)
        let food3 = FoodOnMyTable(name: "Apple", status: "in process", rating: nil)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try JSONEncoder().encode([food, food2, food3])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        } catch {
            print(error)
        }
    }
}

extension ViewController {
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }

    private func parse<T: Codable>(jsonData: Data) -> T?{
        let object: T?
        do {
            object = try ViewController.jsonDecoder.decode(T.self, from: jsonData)
        } catch {
            print("decode error \(error)")
            object = nil
        }
        return object
    }
}
