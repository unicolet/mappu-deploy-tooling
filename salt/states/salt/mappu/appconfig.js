var WMSCONFIG={
{% if ctx_use_cache is defined %}
	use_cache:{{- ctx_use_cache -}},
{%else%}
	use_cache:true,
{% endif %}
	server_path: "{{- ctx_server_path -}}",
	wfs_server_path: "{{- ctx_wfs_server_path -}}",
	server_cache_path: "{{- ctx_server_cache_path -}}",
{% if ctx_default_srs is defined %}
	default_srs:{{- ctx_default_srs -}},
{%else%}
	default_srs:"EPSG:3003",
{%endif%}
{% if ctx_extended_link_regex is defined %}
	extended_link_regex:{{- ctx_extended_link_regex|lower -}},
{%else%}
	extended_link_regex:true,
{%endif%}
{% if ctx_remove_wms_layers_when_not_used is defined %}
	remove_wms_layers_when_not_used:{{- ctx_remove_wms_layers_when_not_used|default(false,true) -}},
{%else%}
	remove_wms_layers_when_not_used:false,
{%endif%}
{% if ctx_default_zoom_level is defined %}
	default_zoom_level:{{- ctx_default_zoom_level -}}
{%else%}
	default_zoom_level:false
{%endif%}
};

var APPCONFIG={
	title:"{{- ctx_title -}}",
	print:{chrome:"/chrome.html",firefox:"/firefox.html",other:"/other.html"},
	admin_user:"admin",
	advanced_options:"/mapsocial/",
{% if ctx_show_tips is defined %}
	showTips:{{- ctx_show_tips -}},
{%else%}
	showTips:false,
{%endif%}
{% if ctx_enable_printing is defined %}
	enablePrinting:{{- ctx_enable_printing|lower -}},
{%else%}
	enablePrinting:true,
{%endif%}
{% if ctx_enable_session_saving is defined %}
        enableSessionSaving: {{- ctx_enable_session_saving|lower -}},
{%else%}
	enableSessionSaving:false,
{%endif%}
{% if ctx_custom_app_logo is defined %}
        custom_app_logo: "{{- ctx_custom_app_logo -}}",
{% else %}
        custom_app_logo: "/source/recources/images/app-logo-huge.png",
{%endif%}
 {% if ctx_attribution is defined %}
        attribution: "{{- ctx_attribution -}}"
{%else%}
        attribution: "mailto:umberto.nicoletti@gmail.com"
{%endif%}
};


var whiteTile='/source/resources/images/white.png';
/*
 Use this variable to customize the base layers used in the map.
 
 Each layer should have a name attribute (used in the radio button label) and a provider,args
 couple where the provider is the name of the OpenLayers layer subclass to use and args is the list of arguments
 to the constructor. PLease note at this stage the OpenLayers objects have not been loaded yet and therefore
 attempting to reference them will throw an error and break your Mappu app.
*/
var MAPPU_BASELAYERS=[
    {name:"Streets", provider: 'OpenLayers.Layer.Google', args:["Streets",{'sphericalMercator': true}]},
    {name:"Satellite", provider: 'OpenLayers.Layer.Google', args:["Satellite",{'type': "satellite",'sphericalMercator': true}]},
    {name:"_blank", provider: 'OpenLayers.Layer.OSM', args:["_blank", whiteTile]}
];


