gfx/impact/blood_drop_stain0
{
	entityMergable
	surfaceparm nonsolid
	surfaceparm trans
	polygonOffset2
    {
        map gfx/impact/blood_drop_stain0
        blendfunc blend
        rgbGen vertex
    nextbundle
		map $lightmap
    }
    {
		perlight
        map gfx/impact/blood_drop_stain0
        blendfunc GL_SRC_ALPHA GL_ONE
        rgbGen vertex
    nextbundle
		map $dlight
    }
}

gfx/impact/blood_drop_stain1
{
	entityMergable
	surfaceparm nonsolid
	surfaceparm trans
	polygonOffset2
    {
        map gfx/impact/blood_drop_stain1
        blendfunc blend
        rgbGen vertex
    nextbundle
		map $lightmap
    }
    {
		perlight
        map gfx/impact/blood_drop_stain1
        blendfunc GL_SRC_ALPHA GL_ONE
        rgbGen vertex
    nextbundle
		map $dlight
    }
}

gfx/impact/blood_drop_stain2
{
	entityMergable
	surfaceparm nonsolid
	surfaceparm trans
	polygonOffset2
    {
        map gfx/impact/blood_drop_stain2
        blendfunc blend
        rgbGen vertex
    nextbundle
		map $lightmap
    }
    {
		perlight
        map gfx/impact/blood_drop_stain2
        blendfunc GL_SRC_ALPHA GL_ONE
        rgbGen vertex
    nextbundle
		map $dlight
    }
}


gfx/impact/blood_drop_stain3
{
	entityMergable
	surfaceparm nonsolid
	surfaceparm trans
	polygonOffset2
    {
        map gfx/impact/blood_drop_stain3
        blendfunc blend
        rgbGen vertex
    nextbundle
		map $lightmap
    }
    {
		perlight
        map gfx/impact/blood_drop_stain3
        blendfunc GL_SRC_ALPHA GL_ONE
        rgbGen vertex
    nextbundle
		map $dlight
    }
}

gfx/impact/blood_droplett1
{
	entityMergable
    {
        map gfx/impact/blood_droplett1
        blendfunc blend
        rgbGen vertex 
    }
}

gfx/impact/blood_drop2
{
	entityMergable
    {
        map gfx/impact/blood_drop2
        blendfunc blend
        rgbGen vertex 
    }
}


gfx/puke/puke_pool
{
	entityMergable
	polygonOffset2
    {
        map gfx/puke/puke_pool1.tga
        blendfunc blend
        rgbGen vertex 
    }
}


gfx/effects/bloodpool1
{
	entityMergable
	polygonOffset2
    {
        map gfx/effects/blood_pool1
        blendfunc blend
        rgbGen vertex 
    }
}
gfx/effects/bloodpool2
{
	entityMergable
	polygonOffset2
    {
        map gfx/effects/blood_pool2
        blendfunc blend
        rgbGen vertex 
    }
}

mc_menu_tag
{
	nopicmip
	nomipmaps
	sort additive
	q3map_nolightmap
	q3map_onlyvertexlighting
    {
        map gfx/effects/mc_env_front
        rgbGen vertex
    }
    {
        map gfx/effects/mc_env_back
        blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
        detail
        alphaGen const 0.8
        tcMod rotate 1
        tcMod scroll 0.05 0.09
    }
    {
        map gfx/effects/mc_env_front
        blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
        detail
    }
}

RedPain_BL
{
	nomipmaps
	nopicmip
	sort	additive
	cull	disable
	{
		map gfx/misc/red_pn1.tga
		blendFunc blend
		rgbGen vertex
	}

}
RedPain_TL
{
	nomipmaps
	nopicmip
	sort	additive
	cull	disable
	{
		map gfx/misc/red_pn2.tga
		blendFunc blend
		rgbGen vertex
	}

}

RedPain_TR
{
	nomipmaps
	nopicmip
	sort	additive
	cull	disable
	{
		map gfx/misc/red_pn3.tga
		blendFunc blend
		rgbGen vertex
	}

}

RedPain_BR
{
	nomipmaps
	nopicmip
	sort	additive
	cull	disable
	{
		map gfx/misc/red_pn4.tga
		blendFunc blend
		rgbGen vertex
	}

}


//NOT USED
/*
PainThrob
{
	nomipmaps
	nopicmip
	sort	additive
	cull	disable
	{
		map gfx/misc/red_pn4.tga
		blendFunc blend
		rgbGen vertex
	}

	}
		map gfx/misc/test123.tga
 		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		detail
     		alphaGen const 0.3
   		tcMod rotate .1
 		tcMod scroll 0.05 0.09
	}
}
Painthrob
{
	nopicmip
	{
		map gfx/misc/red_pn1.tga
		blendfunc gl_src_alpha gl_one
		rgbGen identity
	}
	{
		map gfx/effects/mc_env_back.tga
		blendfunc gl_dst_alpha gl_one
		rgbGen wave sin 0.5 0.2 0 0.1 
		tcMod stretch sin 2 0.1 0.5 0.05 
		tcMod turb 1 0.05 0 0.1
	}
}
*/


medic_powerup
{
	nomipmaps
	nopicmip
	sort	additive
	cull	disable
	{
		map ui_mp/assets/hud@medic_health.tga
		blendFunc blend
		rgbGen vertex
	}

}

explosive_powerup
{
	nomipmaps
	nopicmip
	sort	additive
	cull	disable
	{
		map ui_mp/assets/hud@explosivepack.tga
		blendFunc blend
		rgbGen vertex
	}

}


viewsplat1
{
	nomipmaps
	nopicmip
	sort	additive
	cull	disable
	{
		map gfx/viewsplats/viewsplat1
		blendFunc blend
		rgbGen vertex
	}

}
viewsplat2
{
	nomipmaps
	nopicmip
	sort	additive
	cull	disable
	{
		map gfx/viewsplats/viewsplat2
		blendFunc blend
		rgbGen vertex
	}

}
viewsplat3
{
	nomipmaps
	nopicmip
	sort	additive
	cull	disable
	{
		map gfx/viewsplats/viewsplat3
		blendFunc blend
		rgbGen vertex
	}

}
