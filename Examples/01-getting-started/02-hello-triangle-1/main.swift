// License: http://creativecommons.org/publicdomain/zero/1.0/

// Import the required libraries

import CGLFW3
import SwiftGL
import Foundation

 //Shaders
let vertexShaderSource = """
                         #version 330 core
                         layout (location = 0) in vec3 position;
                         void main() {
                                gl_Position = vec4(position.x, position.y, position.z, 1.0);
                         }
                         """
let fragmentShaderSource = """
                           #version 330 core
                           out vec4 color;
                           void main() {
                                color = vec4(1.0f, 0.5f, 0.2f, 1.0f);
                           }
                           """

// The *main* function; where our program begins running
class HelloTriangle1: WindowRepresentable {

    var windowHeight = 600
    var windowWidth = 800
    var windowName = "Hello Triangle 1"

    func draw() {

        // Build and compile our shader program
        // Vertex shader
        let vertexShader = glCreateShader(type: GL_VERTEX_SHADER)
        vertexShaderSource.withCString {
            var s = [$0]
            glShaderSource(shader: vertexShader, count: 1, string: &s, length: nil)
        }
        glCompileShader(vertexShader)
        // Check for compile time errors
        var success: GLint = 0
        var infoLog = [GLchar](repeating: 0, count: 512)
        glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success)
        guard success == GL_TRUE else {
            glGetShaderInfoLog(vertexShader, 512, nil, &infoLog)
            fatalError(String(cString: infoLog))
        }
        // Fragment shader
        let fragmentShader = glCreateShader(type: GL_FRAGMENT_SHADER)
        fragmentShaderSource.withCString {
            var s = [$0]
            glShaderSource(shader: fragmentShader, count: 1, string: &s, length: nil)
        }
        glCompileShader(fragmentShader)
        // Check for compile time errors
        glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success)
        guard success == GL_TRUE else {
            glGetShaderInfoLog(fragmentShader, 512, nil, &infoLog)
            fatalError(String(cString: infoLog))
        }
        // Link shaders
        let shaderProgram = glCreateProgram()
        defer {
            glDeleteProgram(shaderProgram)
        }
        glAttachShader(shaderProgram, vertexShader)
        glAttachShader(shaderProgram, fragmentShader)
        glLinkProgram(shaderProgram)
        // Check for linking errors
        glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success)
        guard success == GL_TRUE else {
            glGetProgramInfoLog(shaderProgram, 512, nil, &infoLog)
            fatalError(String(cString: infoLog))
        }
        // We no longer need these since they are in the shader program
        glDeleteShader(vertexShader)
        glDeleteShader(fragmentShader)


        // Set up vertex data (and buffer(s)) and attribute pointers)
        let vertices: [GLfloat] = [
            -0.5, -0.5, 0.0, // bottom-left
            0.5, -0.5, 0.0, // bottom-right
            0.0, 0.5, 0.0  // top-center
        ]
        var VAO: GLuint = 0
        glGenVertexArrays(n: 1, arrays: &VAO)
        defer {
            glDeleteVertexArrays(1, &VAO)
        }
        var VBO: GLuint = 0
        glGenBuffers(n: 1, buffers: &VBO)
        defer {
            glDeleteBuffers(1, &VBO)
        }
        // Bind the Vertex Array Object first, then bind and set
        // vertex buffer(s) and attribute pointer(s).
        glBindVertexArray(VAO)

        glBindBuffer(target: GL_ARRAY_BUFFER, buffer: VBO)
        glBufferData(target: GL_ARRAY_BUFFER, size: vertices.size, data: vertices, usage: GL_STATIC_DRAW)

        glVertexAttribPointer(index: 0, size: 3, type: GL_FLOAT,
                normalized: false, stride: GLsizei(GLfloat.stride * 3), pointer: nil)
        glEnableVertexAttribArray(0)

        glBindBuffer(target: GL_ARRAY_BUFFER, buffer: 0) // Note that this is allowed,
        // the call to glVertexAttribPointer registered VBO as the currently bound
        // vertex buffer object so afterwards we can safely unbind.

        glBindVertexArray(0) // Unbind VAO; it's always a good thing to
        // unbind any buffer/array to prevent strange bugs.
        // remember: do NOT unbind the EBO, keep it bound to this VAO.


        // Game loop
        while !windowShouldClose {
            // Check if any events have been activated
            // (key pressed, mouse moved etc.) and call
            // the corresponding response functions
            glfwPollEvents()

            // Render
            // Clear the colorbuffer
            glClearColor(red: 0.2, green: 0.3, blue: 0.3, alpha: 1.0)
            glClear(GL_COLOR_BUFFER_BIT)

            // Draw our first triangle
            glUseProgram(shaderProgram)
            glBindVertexArray(VAO)
            glDrawArrays(GL_TRIANGLES, 0, 3)
            glBindVertexArray(0)

            // Swap the screen buffers
            glfwSwapBuffers(window)
        }
    }
}

// called whenever a key is pressed/released via GLFW
//func keyCallback(window: OpaquePointer!, key: Int32, scancode: Int32, action: Int32, mode: Int32) {
//    if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS) {
//        glfwSetWindowShouldClose(window, GL_TRUE)
//    }
//}

// Start the program with function main()
var programm = HelloTriangle1()
programm.run()
