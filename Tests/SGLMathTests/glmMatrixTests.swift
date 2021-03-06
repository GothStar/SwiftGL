// Copyright (c) 2015-2016 David Turnbull
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and/or associated documentation files (the
// "Materials"), to deal in the Materials without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Materials, and to
// permit persons to whom the Materials are furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Materials.
//
// THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.


import XCTest
import SGLMath

class SwiftGLglmTests: XCTestCase {

    func testGenericLink() {
        // Nothing asserts here.
        // Just making sure the generics will link.

        let m4 = mat4()
        let v2 = vec2(1)
        let v3 = vec3()
        let v4 = vec4()

        let _ = SGLMath.translate(m4, v3)
        let _ = SGLMath.rotate(m4, 1.1, v3)
        let _ = SGLMath.rotateSlow(m4, 1.1, v3)
        let _ = SGLMath.scale(m4, v3)

        let _ = SGLMath.ortho(1,2,3,4,5,6)
        let _ = SGLMath.ortho(1,2,3,4)
        let _ = SGLMath.orthoLH(1,2,3,4,5,6)
        let _ = SGLMath.orthoRH(1,2,3,4,5,6)

        let _ = SGLMath.frustum(1,2,3,4,5,6)
        let _ = SGLMath.frustumLH(1,2,3,4,5,6)
        let _ = SGLMath.frustumRH(1,2,3,4,5,6)

        let _ = SGLMath.perspective(1,2,3,4)
        let _ = SGLMath.perspectiveLH(1,2,3,4)
        let _ = SGLMath.perspectiveRH(1,2,3,4)

        let _ = SGLMath.perspectiveFov(1,2,3,4,5)
        let _ = SGLMath.perspectiveFovLH(1,2,3,4,5)
        let _ = SGLMath.perspectiveFovRH(1,2,3,4,5)

        let _ = SGLMath.infinitePerspective(1,2,3)
        let _ = SGLMath.infinitePerspectiveLH(1,2,3)
        let _ = SGLMath.infinitePerspectiveRH(1,2,3)

        let _ = SGLMath.project(v3, m4, m4, v4)
        let _ = SGLMath.unproject(v3, m4, m4, v4)
        let _ = SGLMath.pickMatrix(v2, v2, v4)

        let _ = SGLMath.lookAt(v3, v3, v3)
        let _ = SGLMath.lookAtLH(v3, v3, v3)
        let _ = SGLMath.lookAtRH(v3, v3, v3)
    }

}
