/*
 * TinyCC.cpp
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
#include "dmgr/impl/DebugMacros.h"
#include "libtcc.h"
#include "TinyCC.h"


namespace jit {
namespace cc {


TinyCC::TinyCC(dmgr::IDebugMgr *dmgr) {
    m_tcc = tcc_new();
}

TinyCC::~TinyCC() {
    tcc_delete(m_tcc);
}

int TinyCC::addIncludePath(const std::string &path) { 
    tcc_add_include_path(m_tcc, path.c_str());
}

int TinyCC::addSysIncludePath(const std::string &path) { 
    tcc_add_sysinclude_path(m_tcc, path.c_str());
}

void TinyCC::definePreProcSym(const std::string &sym, const std::string &value) { 
    tcc_define_symbol(m_tcc, sym.c_str(), value.c_str());
}

void TinyCC::undefPreProcSym(const std::string &sym) {
    tcc_undefine_symbol(m_tcc, sym.c_str());
}

int TinyCC::addSrcFile(const std::string &path) { 
    return tcc_add_file(m_tcc, path.c_str());
}

int TinyCC::addSrcStr(const std::string &src) { 
    return tcc_compile_string(m_tcc, src.c_str());
}

int TinyCC::addSymbol(const std::string &sym, const void *val) { 
    return tcc_add_symbol(m_tcc, sym.c_str(), val);
}

int TinyCC::relocate() { 
    return tcc_relocate(m_tcc);
}

void *TinyCC::getSymbol(const std::string &sym) { 
    return tcc_get_symbol(m_tcc, sym.c_str());
}

dmgr::IDebug *TinyCC::m_dbg = 0;

}
}
