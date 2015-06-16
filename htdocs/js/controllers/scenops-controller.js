// scenops-controller.js
'use strict';

angular.module('arachne')
.controller('ScenarioOpsController', function() {
    this.tab = 'new';
    this.setTab = function(which) {
        this.tab = which;
    };
    this.isSet = function(tab) {
        return this.tab === tab;
    };
});
