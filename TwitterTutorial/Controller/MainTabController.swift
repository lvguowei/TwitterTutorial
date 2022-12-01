import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }

    // MARK: - Helpers
    func configureViewControllers() {
        let feed = FeedController()
        let nav1 = templateNavigationController(
            image: UIImage(named: "home_unselected"), rootViewController: feed)

        let explore = ExploreController()
        let nav2 = templateNavigationController(
            image: UIImage(named: "search_unselected"), rootViewController: explore)
        let notifications = NotificationsController()
        let nav3 = templateNavigationController(
            image: UIImage(named: "search_unselected"), rootViewController: notifications)
        let conversations = ConversationsController()
        let nav4 = templateNavigationController(
            image: UIImage(named: "like_unselected"), rootViewController: conversations)

        viewControllers = [nav1, nav2, nav3, nav4]
    }

    func templateNavigationController(image: UIImage?, rootViewController: UIViewController)
        -> UINavigationController
    {
        let nav = UINavigationController(rootViewController: rootViewController)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance

        nav.tabBarItem.image = image
        return nav
    }

}
