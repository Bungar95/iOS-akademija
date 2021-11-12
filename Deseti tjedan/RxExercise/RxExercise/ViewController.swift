//
//  ViewController.swift
//  RxExercise
//
//  Created by Borna Ungar on 21.07.2021..
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    /// Represents a sequence event.
    ///
    /// Sequence grammar:
    /// **next\* (error | completed)**
    public enum Event<Element> {
        /// Next element is produced.
        case next(Element)
        /// Sequence terminated with an error.
        case error(Swift.Error)
        /// Sequence completed successfully.
        case completed
    }
    
    //MARK: Observables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        example(of: "just, of, from") {
            // 1
            let one = 1
            let two = 2
            let three = 3
            // 2
            let observable = Observable<Int>.just(one)
            let observable2 = Observable.of(one, two, three)
            let observable3 = Observable.of([one, two, three])
            let observable4 = Observable.from([one, two, three])
        }
        
        example(of: "subscribe") {
            let one = 1
            let two = 2
            let three = 3
            let observable = Observable.of(one, two, three)
            
            //            observable.subscribe { event in
            //                print(event)
            //            }
            
            //            observable.subscribe { event in
            //                if let element = event.element {
            //                    print(element)
            //                }
            //            }
            
            observable.subscribe(onNext: { element in
                print(element)
            })
        }
        
        example(of: "empty") {
            let observable = Observable<Void>.empty()
            
            observable.subscribe(
                onNext: { element in
                    print(element)
                },
                onCompleted: {
                    print("Completed")
                }
                // (finite)
            )
        }
        
        example(of: "never") {
            let observable = Observable<Void>.never()
            observable.subscribe(
                onNext: { element in
                    print(element)
                },
                onCompleted: {
                    print("Completed")
                }
            )
            // Nothing is printed because it never ends (infinite)
        }
        
        example(of: "range") {
            // 1
            let observable = Observable<Int>.range(start: 1, count: 10)
            observable
                .subscribe(onNext: { i in
                    // 2
                    let n = Double(i)
                    let fibonacci = Int(
                        ((pow(1.61803, n) - pow(0.61803, n)) /
                            2.23606).rounded()
                    )
                    print(fibonacci)
                })
        }
        
        example(of: "dispose") {
            // 1
            let observable = Observable.of("A", "B", "C")
            // 2
            let subscription = observable.subscribe { event in
                // 3
                print(event)
            }
            subscription.dispose()
        }
        
        example(of: "DisposeBag") {
            // 1
            let disposeBag = DisposeBag()
            
            // 2
            Observable.of("A", "B", "C")
                .subscribe { // 3
                    print($0)
                }
                .disposed(by: disposeBag) // 4
            
            Observable<String>.create {observer in
                observer.onNext("Antonijev Mac...")
                return Disposables.create()
            }.subscribe(
                onNext: { print($0) },
                onDisposed: { print("Disposed") }
            ).dispose()
        }
        
        example(of: "create") {
            enum MyError: Error {
                case anError
            }
            let disposeBag = DisposeBag()
            Observable<String>.create { observer in
                // 1
                observer.onNext("1")
                // 2
                observer.onError(MyError.anError)
                
                observer.onCompleted()
                // 3
                observer.onNext("?")
                // 4
                return Disposables.create()
            }
            .subscribe(
                onNext: { print($0) },
                onError: { print($0) },
                onCompleted: { print("Completed") },
                onDisposed: { print("Disposed") }
            )
            .disposed(by: disposeBag)
        }
        
        example(of: "create (memory leak)") {
            enum MyError: Error {
                case anError
            }
            let disposeBag = DisposeBag()
            Observable<String>.create { observer in
                // 1
                observer.onNext("1")
                // observer.onError(MyError.anError)
                // 2
                // observer.onCompleted()
                // 3
                observer.onNext("?")
                // 4
                return Disposables.create()
            }
            .subscribe(
                onNext: { print($0) },
                
                onError: { print($0) },
                onCompleted: { print("Completed") },
                onDisposed: { print("Disposed") }
            )
            // .disposed(by: disposeBag)
        }
        
        //MARK: Subjects
        
        example(of: "PublishSubject") {
            let subject = PublishSubject<String>()
            subject.on(.next("Is anyone listening?"))
            let subscriptionOne = subject
                .subscribe(onNext: { string in
                    print(string)
                })
            subject.on(.next("1"))
            subject.onNext("2")
            
            let subscriptionTwo = subject
                .subscribe { event in
                    print("2)", event.element ?? event)
                }
            
            subject.onNext("3")
            
            subscriptionOne.dispose()
            subject.onNext("4")
            
            // 1
            subject.onCompleted()
            // 2 This won’t be emitted and printed,
            // though, because the subject has already terminated.
            subject.onNext("5")
            // 3
            subscriptionTwo.dispose()
            let disposeBag = DisposeBag()
            // 4
            subject
                .subscribe {
                    print("3)", $0.element ?? $0)
                }
                .disposed(by: disposeBag)
            subject.onNext("?")
        }
        
        example(of: "BehaviorSubject") {
            // Because BehaviorSubject always emits its latest element, you can’t create one without providing an initial value. If you can’t provide an initial value at creation time, that probably means you need to use a PublishSubject instead, or model your element as an Optional.
            let subject = BehaviorSubject(value: "Initial value")
            let disposeBag = DisposeBag()
            subject.onNext("X")
            subject
                .subscribe {
                    print("1) \($0)")
                }
                .disposed(by: disposeBag)
        }
        
        example(of: "ReplaySubject") {
            // 1
            let subject = ReplaySubject<String>.create(bufferSize: 2)
            let disposeBag = DisposeBag()
            // 2
            subject.onNext("1")
            subject.onNext("2")
            subject.onNext("3")
            // 3
            subject
                .subscribe {
                    print("1) \($0)")
                }
                .disposed(by: disposeBag)
            
            subject
                .subscribe {
                    print("2) \($0)")
                }
                .disposed(by: disposeBag)
            
            subject.onNext("4")
            subject
                .subscribe {
                    print("3) \($0)")
                }
                .disposed(by: disposeBag)
        }
        
        example(of: "PublishRelay") {
            let relay = PublishRelay<String>()
            let disposeBag = DisposeBag()
            
            relay.accept("Knock knock, anyone home?")
            relay
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
            relay.accept("1")
        }
        
        example(of: "BehaviorRelay") {
            // 1
            let relay = BehaviorRelay(value: "Initial value")
            let disposeBag = DisposeBag()
            // 2
            relay.accept("New initial value")
            // 3
            relay
                .subscribe {
                    print("1) \($0)")
                }
                .disposed(by: disposeBag)
            
            relay.accept("1")
            // 2
            relay
                .subscribe {
                    print("2) \($0)")
                }
                .disposed(by: disposeBag)
            // 3
            relay.accept("2")
            print(relay.value)
        }
        
        example(of: "ignoreElements") {
            // 1
            let strikes = PublishSubject<String>()
            let disposeBag = DisposeBag()
            strikes.onNext("X")
            strikes.onNext("X")
            strikes.onNext("X")
            strikes.onCompleted()
            
            // 2
            strikes
                .ignoreElements()
                .subscribe { _ in
                    print("You're out!")
                }
                .disposed(by: disposeBag)
        }
        
        example(of: "filter") {
            let disposeBag = DisposeBag()
            // 1
            Observable.of(1, 2, 3, 4, 5, 6)
                // 2
                .filter { $0.isMultiple(of: 2) }
                // 3
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        example(of: "skip") {
            let disposeBag = DisposeBag()
            // 1
            Observable.of("A", "B", "C", "D", "E", "F")
                // 2
                .skip(3)
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        example(of: "skipWhile") {
            //skip only skips elements up until the first element is let through, and then all remaining elements are allowed through.
            let disposeBag = DisposeBag()
            // 1
            Observable.of(2, 2, 3, 4, 4)
                // 2
                .skipWhile { $0.isMultiple(of: 2) }
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        example(of: "skipUntil") {
            let disposeBag = DisposeBag()
            // 1
            let subject = PublishSubject<String>()
            let trigger = PublishSubject<String>()
            
            // 2
            subject
                .skip(until: trigger)
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
            
            subject.onNext("A")
            subject.onNext("B")
            trigger.onNext("X")
            subject.onNext("C")
        }
        
        example(of: "take") {
            let disposeBag = DisposeBag()
            // 1
            Observable.of(1, 2, 3, 4, 5, 6)
                // 2
                .take(3)
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        example(of: "takeWhile") {
            let disposeBag = DisposeBag()
            // 1
            Observable.of(2, 2, 4, 4, 6, 6)
                // 2
                .enumerated()
                // 3
                .takeWhile { index, integer in
                    // 4
                    integer.isMultiple(of: 2) && index < 3
                }
                // 5
                .map(\.element)
                // 6
                .subscribe(onNext: {
                    print($0)
                })
            
        }
        
        example(of: "takeUntil") {
            let disposeBag = DisposeBag()
            // 1
            Observable.of(1, 2, 3, 4, 5)
                // 2
                .take(until: { $0.isMultiple(of: 4) }, behavior: .exclusive)
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        example(of: "takeUntil trigger") {
            let disposeBag = DisposeBag()
            // 1
            let subject = PublishSubject<String>()
            let trigger = PublishSubject<String>()
            // 2
            subject
                .take(until: trigger)
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
            // 3
            subject.onNext("1")
            subject.onNext("2")
            trigger.onNext("X")
            subject.onNext("3")
        }
        
        example(of: "distinctUntilChanged") {
            //operator only prevents contiguous duplicates
            let disposeBag = DisposeBag()
            // 1
            Observable.of("A", "A", "B", "B", "A")
                // 2
                .distinctUntilChanged()
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        example(of: "toArray") {
            let disposeBag = DisposeBag()
            // 1
            Observable.of("A", "B", "C")
                // 2
                .toArray()
                .subscribe(onSuccess: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        example(of: "map") {
            let disposeBag = DisposeBag()
            // 1
            let formatter = NumberFormatter()
            formatter.numberStyle = .spellOut
            // 2
            Observable<Int>.of(123, 4, 56, 69)
                // 3
                .map {
                    formatter.string(for: $0) ?? ""
                }
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        example(of: "enumerated and map") {
            let disposeBag = DisposeBag()
            // 1
            Observable.of(1, 2, 3, 4, 5, 6)
                // 2
                .enumerated()
                // 3
                .map { index, integer in
                    index > 2 ? integer * 2 : integer
                }
                // 4
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        example(of: "compactMap") {
            //The compactMap operator is a combination of the map and filter operators that specifically filters out nil values,
            let disposeBag = DisposeBag()
            // 1
            Observable.of("To", "be", nil, "or", "not", "to", "be", nil)
                // 2
                .compactMap { $0 }
                // 3
                .toArray()
                // 4
                .map { $0.joined(separator: " ") }
                // 5
                .subscribe(onSuccess: {
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        //MARK: Student struct examples
        struct Student {
            let score: BehaviorSubject<Int>
        }
        
        example(of: "flatMap") {
            let disposeBag = DisposeBag()
            // 1
            let laura = Student(score: BehaviorSubject(value: 80))
            let charlotte = Student(score: BehaviorSubject(value: 90))
            // 2
            let student = PublishSubject<Student>()
            // 3
            student
                .flatMap {
                    $0.score
                }
                // 4
                .subscribe(onNext: {
                    print($0)
                })
                .disposed(by: disposeBag)
            
            student.onNext(laura)
            laura.score.onNext(85)
            student.onNext(charlotte)
        }
        
        example(of: "flatMapLatest") {
        let disposeBag = DisposeBag()
        let laura = Student(score: BehaviorSubject(value: 80))
        let charlotte = Student(score: BehaviorSubject(value: 90))
        let student = PublishSubject<Student>()
        student
        .flatMapLatest {
        $0.score
        }
        .subscribe(onNext: {
        print($0)
        })
        .disposed(by: disposeBag)
        student.onNext(laura)
        laura.score.onNext(85)
        student.onNext(charlotte)
        // 1
        laura.score.onNext(95)
        charlotte.score.onNext(100)
        }
    }
}

