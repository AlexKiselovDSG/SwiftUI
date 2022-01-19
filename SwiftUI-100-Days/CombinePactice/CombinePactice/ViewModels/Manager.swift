//
//  Manager.swift
//  CombinePactice
//
//  Created by Kiselov, Oleksandr on 1/18/22.
//


import Combine
import SwiftUI

class Manager: ObservableObject {
    @Published var gameImages:[GameImage] = []
    @Published var score = 0
    @Published var isPlay = false
    @Published var level = 0
    @Published var error: GameError? = nil
    private var timer: AnyCancellable?
    private var subscriptions: Set<AnyCancellable> = []
    
    private func startGame() {
        score += 200
        level += 1
        timer?.cancel()
        downloadImages()
    }
   
    private func stopGame() {
        timer?.cancel()
        isPlay = false
        level = 0
        score = 0
    }
    
    func changeGameState() {
        isPlay.toggle()
        if isPlay {
            startGame()
        } else {
            stopGame()
        }
    }
    
    func click(on gameImage: GameImage) {
        if !isPlay {
            return
        }
        if !gameImage.isAnswer {
            stopGame()
        } else {
            startGame()
        }
    }
    
    private func downloadImages() {
        let firstImg = UnsplashAPI.randomImage()
            .flatMap {RandomImageResponse in
                ImageDownloader.download(url: RandomImageResponse.urls.regular)
            }
        let secondImg = UnsplashAPI.randomImage()
            .flatMap {RandomImageResponse in
                ImageDownloader.download(url: RandomImageResponse.urls.regular)
            }
        
        firstImg.zip(secondImg)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[unowned self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.stopGame()
                    self.error = error
                }
                
            }, receiveValue: { [unowned self] first, second in
                let firstImage = GameImage(image: first, isAnswer: true)
                let secondImage = GameImage(image: second, isAnswer: false)
                self.gameImages = [firstImage, secondImage, secondImage, secondImage].shuffled()
                
                timer = Timer.publish(every: 0.1, on: RunLoop.main, in: .common)
                    .autoconnect()
                    .sink(receiveValue: { [unowned self] _ in
                        self.error = nil
                        self.score -= 10
                        if self.score < 0 {
                            self.score = 0
                            self.stopGame()
                        }
                    })
                
            })
            .store(in: &subscriptions)
    }
    
    
   
    
    
    init() {
        //downloadImages()
//        $isPlay
//            .dropFirst()
//            .sink { [unowned self ] isPlay in
//                if isPlay {
//                    self.startGame()
//                } else {
//                    self.stopGame()
//                }
//            }
//            .store(in: &subscriptions)
    }
   
   
    
    
}
