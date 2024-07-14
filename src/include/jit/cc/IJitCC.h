/**
 * ITinyCC.h
 *
 * Copyright 2023 Matthew Ballance and Contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may 
 * not use this file except in compliance with the License.  
 * You may obtain a copy of the License at:
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, 
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
 * See the License for the specific language governing permissions and 
 * limitations under the License.
 *
 * Created on:
 *     Author: 
 */
#pragma once
#include <memory>
#include <string>

namespace jit {
namespace cc {

class IJitCC;
using IJitCCUP=std::unique_ptr<IJitCC>;
class IJitCC {
public:

    virtual ~IJitCC() { }

    virtual int addIncludePath(const std::string &path) = 0;

    virtual int addSysIncludePath(const std::string &path) = 0;

    virtual void definePreProcSym(const std::string &sym, const std::string &value) = 0;

    virtual void undefPreProcSym(const std::string &sym) = 0;

    virtual int addSrcFile(const std::string &path) = 0;

    virtual int addSrcStr(const std::string &src) = 0;

    virtual int addSymbol(const std::string &sym, const void *val) = 0;

    virtual int relocate() = 0;

    virtual void *getSymbol(const std::string &sym) = 0;

};

} /* namespace cc */
} /* namespace jit */


