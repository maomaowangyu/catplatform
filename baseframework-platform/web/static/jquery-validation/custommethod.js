jQuery.validator.addMethod("isEN", function(value, element) {
    var tel = /^[A-Za-z0-9]*$/;
    return this.optional(element) || (tel.test(value));
}, "只能输入英文和数字");

jQuery.validator.addMethod("isENC", function(value, element) {
    var tel = /^[\u4E00-\u9FA5A-Za-z0-9]*$/;
    return this.optional(element) || (tel.test(value));
}, "只能输入中文、英文或数字");

jQuery.validator.addMethod("isNUM", function(value, element) {
    var tel = /^[0-9]*$/;
    return this.optional(element) || (tel.test(value));
}, "只能输入数字");
