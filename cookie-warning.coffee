###
# Copyright (C) 2014-2016 Andrey Antukh <niwi@niwi.nz>
# Copyright (C) 2014-2016 Jesús Espino Garcia <jespinog@gmail.com>
# Copyright (C) 2014-2016 David Barragán Merino <bameda@dbarragan.com>
# Copyright (C) 2014-2016 Alejandro Alonso <alejandro.alonso@kaleidos.net>
# Copyright (C) 2014-2016 Juan Francisco Alcántara <juanfran.alcantara@kaleidos.net>
# Copyright (C) 2014-2016 Xavi Julian <xavier.julian@kaleidos.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: github-auth.coffee
###

template = """
<cookie-warning>
    <div class="center">
        <div class="text">
            <p class="title">
                Our site uses cookies, which our Oompa Loompas munch on to keep our site running.
            </p>
            <p>
                Our lawyer, who is one tough cookie, and is himself obsessed with cookies, wants you
                to know that Taiga uses cookies. He's a simple-minded man, and requires obvious
                announcements like this. So here it is: our cookie policy, which you can read more
                about by <a target="_blank" href="{{::privacyPolicyUrl }}">clicking here</a> is best
                summarized by the Cookie Monster himself: "C is for Cookie and Cookie is for me."
            </p>
        </div>
        <a href="" title="close" class="close"><span class="icon icon-delete"></span></a>
    </div>
</cookie-warning>
"""

CookieWarningDirective = ($compile, $config) ->
    setCookie = (cname, cvalue, exdays) ->
        d = new Date()
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000))
        expires = "expires=" + d.toUTCString()
        document.cookie = cname + "=" + cvalue + "; " + expires

    getCookie = (cname) ->
        name = cname + "="
        ca = document.cookie.split(';')

        for c in ca
            while (c.charAt(0) == ' ')
                c = c.substring(1)

            if (c.indexOf(name) != -1)
                return c.substring(name.length, c.length)

    link = ($scope, $el, $attrs) ->
        $scope.privacyPolicyUrl = $config.get("privacyPolicyUrl")

        cookieMsg = $compile($(template))($scope)

        $el.append(cookieMsg)

        if getCookie('cookieConsent') != '1'
            cookieMsg.show()

        $el.find('.close').on 'click', (e) ->
            e.preventDefault()

            cookieMsg.fadeOut('fast')
            setCookie('cookieConsent', 1, 730)

    return {
        restrict: "E"
        link: link
    }

module = angular.module('cookieWarningPlugin', [])
module.directive("body", ["$compile", "$tgConfig", CookieWarningDirective])
