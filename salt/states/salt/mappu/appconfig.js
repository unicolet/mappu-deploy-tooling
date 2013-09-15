var WMSCONFIG={
{% if ctx_use_cache is defined %}
	use_cache:{{- ctx_use_cache -}},
{%else%}
	use_cache:true,
{% endif %}
	server_path: {{- ctx_server_path -}},
	wfs_server_path: {{- ctx_wfs_server_path -}},
	server_cache_path: {{- ctx_server_cache_path -}},
{% if ctx_default_srs is defined %}
	default_srs:{{- ctx_default_srs -}},
{%else%}
	default_srs:"EPSG:3003",
{%endif%}
{% if ctx_default_srs is defined %}
	extended_link_regex:{{- ctx_extended_link_regex -}},
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
	showTips:{{- ctx_show_tips -}}
{%else%}
	showTips:false
{%endif%}
};
