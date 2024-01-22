/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
var compareOptions=function(e,r,n){if(typeof n==="function"){return n(e,r)}else if(typeof n==="string"){return e[n]===r[n]}else{return Array.isArray(r)?r.includes(e):e===r}};var isOptionSelected=function(e,r,n){if(e===undefined){return false}if(Array.isArray(e)){return e.some((function(e){return compareOptions(e,r,n)}))}else{return compareOptions(e,r,n)}};export{compareOptions as c,isOptionSelected as i};