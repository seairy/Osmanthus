module ApplicationHelper
  def navbar_default_tag
    raw "<nav class=\"w-nav-menu nav-menu bg-gradient\" role=\"navigation\">
          <div class=\"nav-menu-header\">
            <div class=\"logo\">小信鸽</div>
          </div>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"#{url_for(web_home_path)}\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-home-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">首页</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"#{url_for(set_destinations_new_web_travel_path)}\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-box-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">创建新行程</div>
            <div class=\"nav-menu-text-right\">0</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"calendar.html\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-calendar-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">Calendar</div>
          </a>
          <div class=\"w-dropdown dropdown-container\" data-delay=\"0\">
            <div class=\"w-dropdown-toggle w-clearfix nav-menu-link dropdown\">
              <div class=\"icon-list-menu\">
                <div class=\"icon ion-ios-home-outline\"></div>
              </div>
              <div class=\"nav-menu-titles\">App Interface</div>
              <div class=\"w-icon-dropdown-toggle dropdown-icon\"></div>
            </div>
            <nav class=\"w-dropdown-list drop-down-list\">
              <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"splash.html\" data-load=\"1\">
                <div class=\"icon-list-menu\">
                  <div class=\"icon ion-ios-home-outline\"></div>
                </div>
                <div class=\"nav-menu-titles\">Splash Screen</div>
              </a>
              <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"login.html\" data-load=\"1\">
                <div class=\"icon-list-menu\">
                  <div class=\"icon ion-ios-download-outline\"></div>
                </div>
                <div class=\"nav-menu-titles\">Login</div>
              </a>
              <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"signup.html\" data-load=\"1\">
                <div class=\"icon-list-menu\">
                  <div class=\"icon ion-ios-cloud-upload-outline\"></div>
                </div>
                <div class=\"nav-menu-titles\">Sign Up</div>
              </a>
              <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"forgot.html\" data-load=\"1\">
                <div class=\"icon-list-menu\">
                  <div class=\"icon ion-ios-unlocked-outline\"></div>
                </div>
                <div class=\"nav-menu-titles\">Remember Password</div>
              </a>
              <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"messages.html\" data-load=\"1\">
                <div class=\"icon-list-menu\">
                  <div class=\"icon ion-ios-albums-outline\"></div>
                </div>
                <div class=\"nav-menu-titles\">Messages</div>
                <div class=\"nav-menu-text-right\">3</div>
              </a>
              <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"chat.html\" data-load=\"1\">
                <div class=\"icon-list-menu\">
                  <div class=\"icon ion-ios-chatboxes-outline\"></div>
                </div>
                <div class=\"nav-menu-titles\">Chat</div>
              </a>
              <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"about-us.html\" data-load=\"1\">
                <div class=\"icon-list-menu\">
                  <div class=\"icon ion-ios-person-outline\"></div>
                </div>
                <div class=\"nav-menu-titles\">About the App</div>
              </a>
            </nav>
          </div>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"gallery.html\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-camera-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">Gallery</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"portfolio.html\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"ion-ios-folder-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">Portfolio</div>
            <div class=\"nav-menu-text-right\">8</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"videos.html\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-film-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">Videos</div>
          </a>
          <div class=\"w-dropdown dropdown-container\" data-delay=\"0\">
            <div class=\"w-dropdown-toggle w-clearfix nav-menu-link dropdown\">
              <div class=\"icon-list-menu\">
                <div class=\"icon ion-ios-home-outline\"></div>
              </div>
              <div class=\"nav-menu-titles\">Pages</div>
              <div class=\"w-icon-dropdown-toggle dropdown-icon\"></div>
            </div>
            <nav class=\"w-dropdown-list drop-down-list\">
              <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"todo-list.html\" data-load=\"1\">
                <div class=\"icon-list-menu\">
                  <div class=\"icon ion-ios-list-outline\"></div>
                </div>
                <div class=\"nav-menu-titles\">To Do List</div>
                <div class=\"nav-menu-text-right\">8</div>
              </a>
              <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"addnew.html\" data-load=\"1\">
                <div class=\"icon-list-menu\">
                  <div class=\"icon ion-ios-checkmark-outline\"></div>
                </div>
                <div class=\"nav-menu-titles\">Create Task</div>
              </a>
              <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"blog-post.html\" data-load=\"1\">
                <div class=\"icon-list-menu\">
                  <div class=\"icon ion-ios-compose-outline\"></div>
                </div>
                <div class=\"nav-menu-titles\">Blog Post</div>
              </a>
              <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"groups.html\" data-load=\"1\">
                <div class=\"icon-list-menu\">
                  <div class=\"icon ion-ios-keypad-outline\"></div>
                </div>
                <div class=\"nav-menu-titles\">Categories</div>
                <div class=\"nav-menu-text-right\">9</div>
              </a>
            </nav>
          </div>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"news.html\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-paper-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">Blog</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"maps.html\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-location-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">Maps</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"contact.html\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-at-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">Contact</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"social-media.html\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-social-facebook-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">Social Media</div>
            <div class=\"nav-menu-text-right\">3</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link\" href=\"settings.html\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-gear-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">Settings</div>
          </a>
          <a class=\"w-clearfix w-inline-block nav-menu-link last\" href=\"terms.html\" data-load=\"1\">
            <div class=\"icon-list-menu\">
              <div class=\"icon ion-ios-bookmarks-outline\"></div>
            </div>
            <div class=\"nav-menu-titles\">Terms and Conditions</div>
          </a>
          <div class=\"separator-bottom\"></div>
          <div class=\"separator-bottom\"></div>
          <div class=\"separator-bottom\"></div>
        </nav>"
  end
end