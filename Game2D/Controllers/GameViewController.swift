//
//  ViewController.swift
//  Game2D
//
//  Created by Andrei Bogoslovskii on 08.10.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    var spaceship: UIImageView!
    var background: UIImageView!
    var currentScore: Int = 0
    var stoneViews: [UIImageView] = []
    var displayLink: CADisplayLink!
    var stoneSpeed: CGFloat = 2
    let stoneCreationTime: TimeInterval = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        background = UIImageView(image: UIImage(named: "background"))
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
        
        // Создание корабля
        spaceship = UIImageView(
            frame: CGRect(
                x: self.view.frame.width / 2,
                y: self.view.frame.size.height * 0.8,
                width: 50,
                height: 100
            )
        )
        spaceship.image = UIImage(named: "spaceship")
        view.addSubview(spaceship)
        
        
        // взаимодействие с кораблем
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: .current, forMode: .default)
        createStone()
        
    }
    
    @objc func createStone() {
        let stone = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        stone.center.x = CGFloat.random(in: 0...view.bounds.maxX)
        stone.image = UIImage(named: "asteroid")
        view.addSubview(stone)
        stoneViews.append(stone)
    }
    
    // Функция для управления позицией корабля
    @objc
    private func handleTap(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.view)
        if tapLocation.x < self.view.center.x {
            // если слева от центра, то двигайте влево
            UIView.animate(withDuration: 0.5) {
                self.spaceship.center.x -= 30
            }
            
        } else {
            // если справа от центра, то двигайте вправо
            UIView.animate(withDuration: 0.5) {
                self.spaceship.center.x += 30
            }
        }
        
        // ограничение перемещения машины в пределах экрана
        if self.spaceship.center.x < 25 {
            gameOver(reason: "Wall")
        } else if self.spaceship.center.x > self.view.bounds.width - 25 {
            gameOver(reason: "Wall")
        }
    }
    
    
    @objc func update() {
        for stone in stoneViews {
            stone.center.y += stoneSpeed
            if stone.frame.intersects(spaceship.frame) {
                displayLink.isPaused = true
                for stone in stoneViews {
                    stone.removeFromSuperview()
                }
                gameOver(reason: "Stone")
                return
            }
            
            if stone.frame.maxY > view.bounds.maxY {
                stone.removeFromSuperview()
                stoneViews.removeAll(where: { $0 == stone })
                currentScore += 1
                let maxScore = UserDefaults.standard.integer(forKey: "MaxScore")
                if currentScore > maxScore {
                    UserDefaults.standard.setValue(currentScore, forKey: "MaxScore")
                }
            }
        }
        
        if CGFloat.random(in: 0...1) < 0.01 {
            createStone()
        }
    }
    
    // Функция для завершения игры после столкновения
    func gameOver(reason: String) {
        
        displayLink.isPaused = true
        
        for stone in stoneViews {
            stone.layer.removeAllAnimations()
            stone.removeFromSuperview()
        }
        stoneViews.removeAll()
        spaceship.removeFromSuperview()
        
        
        // Отображаем сообщение о конце игры
        let alertController = UIAlertController(
            title: "Game Over",
            message: "",
            preferredStyle: .alert
        )
        
        if reason == "Wall" {
            alertController.message = "You've hit a wall!"
        } else {
            alertController.message = "Your ship is destroyed by an asteroid!"
        }
        
        let restartAction = UIAlertAction(
            title: "Try again",
            style: .default
        ) { [weak self] _ in
            self?.resetGame()
        }
        let exitAction = UIAlertAction(
            title: "I want to go to mommy",
            style: .default
        ) { [weak self] _ in
            self?.exitGame()
        }
        alertController.addAction(restartAction)
        alertController.addAction(exitAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func resetGame() {
        // Создаем корабль снова
        spaceship = UIImageView(
            frame: CGRect(
                x: self.view.frame.width / 2,
                y: self.view.frame.size.height * 0.8, width: 50, height: 100
            )
        )
        spaceship.image = UIImage(named: "spaceship")
        view.addSubview(spaceship)
        
        // Перезапускаем CADisplayLink
        displayLink.isPaused = false
        
        currentScore = 0
    }
    
    func exitGame() {
        navigationController?.popViewController(animated: true)
    }
}

