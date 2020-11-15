import React, { useEffect, useState } from 'react';
import { userService } from '@services';
import { useHistory } from 'react-router-dom';
import axios from 'axios';

export default function withAuth(InnerComponent) {
  return function WrapperComponent(props) {
    const source = axios.CancelToken.source();

    const history = useHistory();
    const [user, setUser] = useState(null);

    const checkLogin = async () => {
      try {
        const { data, status } = await userService.checkLogin({ cancelToken: source.token });
        if (status === 200) {
          setUser(data.user);
        }
      } catch (err) {
        history.push('/login');
      }
    };

    useEffect(async () => {
      checkLogin();
      return () => {
        source.cancel('checkLogin 요청 취소');
      };
    }, []);

    return user ? <InnerComponent user={user} {...props} /> : <div>Loading</div>;
  };
}
