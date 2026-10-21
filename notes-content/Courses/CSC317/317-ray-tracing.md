Tags:

---

Shading:
- light direction = l, this is a unit vector pointing toward the light source
- view direction = v, unit vector pointing toward eye or camera
- surface normal = n, unit vector perpendicular to the surface at the point where the reflection takes place.

Lambertian Shading
$$L = k_d I \max(0, \vec{n} \cdot \vec{l})$$

L is the pixel color; kd is the _diffuse coefficient_, or the surface color; and I is the intensity of the light source.
- view independent: the color of a surface does not depend on the direction from which you look.

Blinn-Phong Shading
$$ \vec{h} = \frac{\vec{v} + \vec{l}}{||\vec{v} + \vec{l}||} $$
$$ L = k_d I \max(0, \vec{n} \cdot \vec{l}) + k_s I \max(0, \vec{n} \cdot \vec{h})^p $$ 
where $k_s$ is the specular coefficient / specular colour of the surface.



<h6 style="font-weight: normal;">See Also</h6>

---

<h6 style="font-weight: normal;">References</h6>

---